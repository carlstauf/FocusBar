//
//  PomodoroTimerModel.swift
//  FocusBar
//
//  A drift-proof Pomodoro timer model using wall clock timestamps
//

import Foundation
import SwiftUI
import Combine
import AppKit

enum TimerState {
    case idle
    case focus
    case shortBreak
    case longBreak
    
    var displayName: String {
        switch self {
        case .idle: return "Ready"
        case .focus: return "Focus"
        case .shortBreak: return "Short Break"
        case .longBreak: return "Long Break"
        }
    }
    
    var color: String {
        switch self {
        case .idle: return "white"
        case .focus: return "red"
        case .shortBreak, .longBreak: return "green"
        }
    }
}

class PomodoroTimerModel: ObservableObject {
    @Published var timeRemaining: Int = 1500 // 25 minutes in seconds
    @Published var isRunning = false
    @Published var isPaused = false
    @Published var state: TimerState = .idle
    @Published var completedCycles = 0
    
    private var endTime: Date?
    private var timer: Timer?
    private var settings: SettingsModel
    private var notificationService: NotificationService
    private var soundService: SoundService
    
    init(settings: SettingsModel, notificationService: NotificationService, soundService: SoundService) {
        self.settings = settings
        self.notificationService = notificationService
        self.soundService = soundService
        
        // Restore state from UserDefaults
        restoreState()
        
        // Listen for sleep/wake notifications
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(handleWake),
            name: NSWorkspace.didWakeNotification,
            object: nil
        )
    }
    
    deinit {
        NSWorkspace.shared.notificationCenter.removeObserver(self)
    }
    
    // MARK: - Public Methods
    
    func start() {
        if state == .idle {
            state = .focus
            timeRemaining = settings.focusLength * 60
            soundService.playFocusStart()
        }
        
        endTime = Date().addingTimeInterval(TimeInterval(timeRemaining))
        isRunning = true
        isPaused = false
        
        startTimer()
        saveState()
    }
    
    func pause() {
        guard !settings.strictMode else { return }
        
        isRunning = false
        isPaused = true
        timer?.invalidate()
        timer = nil
        saveState()
    }
    
    func resume() {
        guard isPaused else { return }
        
        endTime = Date().addingTimeInterval(TimeInterval(timeRemaining))
        isRunning = true
        isPaused = false
        
        startTimer()
        saveState()
    }
    
    func reset() {
        stop()
        state = .idle
        timeRemaining = 0
        completedCycles = 0
        saveState()
    }
    
    func skip() {
        stop()
        advanceToNextState()
        
        if settings.autoStart {
            start()
        }
    }
    
    // MARK: - Timer Display
    
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var menuBarLabel: String {
        if settings.compactMode {
            // Compact mode: show only icon
            switch state {
            case .idle:
                return "⏱"
            case .focus:
                return "🟢"  // Green for focus
            case .shortBreak, .longBreak:
                return "🔵"  // Blue for break
            }
        } else {
            // Normal mode: show timer text
            if state == .idle {
                return "00:00"
            }
            return timeString
        }
    }
    
    var menuBarColor: Color {
        switch state {
        case .idle:
            return .primary  // Auto/default
        case .focus:
            return .green
        case .shortBreak, .longBreak:
            return .blue
        }
    }
    
    // MARK: - Private Methods
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    private func stop() {
        isRunning = false
        isPaused = false
        timer?.invalidate()
        timer = nil
        endTime = nil
        saveState()
    }
    
    private func tick() {
        guard let end = endTime else { return }
        
        let remaining = Int(end.timeIntervalSinceNow)
        timeRemaining = max(remaining, 0)
        
        if timeRemaining <= 0 {
            completeCycle()
        }
    }
    
    private func completeCycle() {
        stop()
        
        // Play appropriate end sound
        if state == .focus {
            soundService.playFocusEnd()
        } else {
            soundService.playBreakEnd()
        }
        
        // Send notification
        let title = state == .focus ? "Focus Complete!" : "Break Over!"
        let body = state == .focus ? "Time for a break." : "Ready to focus again?"
        notificationService.sendNotification(title: title, body: body)
        
        // Track completed cycles (only count focus sessions)
        if state == .focus {
            completedCycles += 1
        }
        
        // Reset cycle counter after long break
        if state == .longBreak {
            completedCycles = 0
        }
        
        // Advance state
        advanceToNextState()
        
        // Auto-start if enabled
        if settings.autoStart {
            start()
        }
        
        saveState()
    }
    
    private func advanceToNextState() {
        switch state {
        case .idle:
            state = .focus
            timeRemaining = settings.focusLength * 60
        case .focus:
            // Long break happens after every 4th completed focus session
            if settings.longBreakEnabled && completedCycles > 0 && completedCycles % 4 == 0 {
                state = .longBreak
                timeRemaining = settings.longBreakLength * 60
            } else {
                state = .shortBreak
                timeRemaining = settings.breakLength * 60
            }
            soundService.playBreakStart()
        case .shortBreak, .longBreak:
            state = .focus
            timeRemaining = settings.focusLength * 60
            soundService.playFocusStart()
        }
    }
    
    @objc private func handleWake() {
        // Recalculate time after wake
        if isRunning, let end = endTime {
            let remaining = Int(end.timeIntervalSinceNow)
            
            if remaining <= 0 {
                // Timer expired during sleep
                completeCycle()
            } else {
                timeRemaining = remaining
            }
        }
    }
    
    // MARK: - Persistence
    
    private func saveState() {
        UserDefaults.standard.set(timeRemaining, forKey: "timeRemaining")
        UserDefaults.standard.set(isRunning, forKey: "isRunning")
        UserDefaults.standard.set(isPaused, forKey: "isPaused")
        UserDefaults.standard.set(completedCycles, forKey: "completedCycles")
        UserDefaults.standard.set(state.displayName, forKey: "state")
        
        if let end = endTime {
            UserDefaults.standard.set(end, forKey: "endTime")
        } else {
            UserDefaults.standard.removeObject(forKey: "endTime")
        }
    }
    
    private func restoreState() {
        timeRemaining = UserDefaults.standard.integer(forKey: "timeRemaining")
        completedCycles = UserDefaults.standard.integer(forKey: "completedCycles")
        
        let wasRunning = UserDefaults.standard.bool(forKey: "isRunning")
        isPaused = UserDefaults.standard.bool(forKey: "isPaused")
        
        if let stateName = UserDefaults.standard.string(forKey: "state") {
            switch stateName {
            case "Focus": state = .focus
            case "Short Break": state = .shortBreak
            case "Long Break": state = .longBreak
            default: state = .idle
            }
        }
        
        if wasRunning, let savedEndTime = UserDefaults.standard.object(forKey: "endTime") as? Date {
            let remaining = Int(savedEndTime.timeIntervalSinceNow)
            
            if remaining > 0 {
                // Timer is still valid, resume it
                timeRemaining = remaining
                endTime = savedEndTime
                isRunning = true
                startTimer()
            } else {
                // Timer expired while app was closed
                timeRemaining = 0
                state = .idle
            }
        }
    }
}
