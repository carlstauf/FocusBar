//
//  FocusBarApp.swift
//  FocusBar
//
//  Created by Carl Stauffer on 12/2/25.
//

import SwiftUI
import UserNotifications

@main
struct FocusBarApp: App {
    @StateObject private var settings = SettingsModel()
    @StateObject private var notificationService: NotificationService
    @StateObject private var timerModel: PomodoroTimerModel
    
    init() {
        let settings = SettingsModel()
        let notificationService = NotificationService()
        let soundService = SoundService(settings: settings)
        let timerModel = PomodoroTimerModel(settings: settings, notificationService: notificationService, soundService: soundService)
        
        _settings = StateObject(wrappedValue: settings)
        _notificationService = StateObject(wrappedValue: notificationService)
        _timerModel = StateObject(wrappedValue: timerModel)
        
        notificationService.configure(with: settings)
    }
    
    var body: some Scene {
        MenuBarExtra {
            MenuBarContentView()
                .environmentObject(timerModel)
                .environmentObject(settings)
        } label: {
            Text(timerModel.menuBarLabel)
                .monospacedDigit()
                .font(.system(.body, design: .rounded))
        }
        .menuBarExtraStyle(.window)
    }
}
