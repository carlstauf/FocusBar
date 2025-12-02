//
//  SoundService.swift
//  FocusBar
//
//  Handles all sound playback for timer events
//

import Foundation
import AppKit
import Combine

class SoundService: ObservableObject {
    private var settings: SettingsModel?
    
    // Available sound types
    enum SoundType: String, CaseIterable {
        case ding = "Ping"
        case bell = "Glass"
        case pop = "Pop"
        case basso = "Basso"
        case blow = "Blow"
        case bottle = "Bottle"
        case frog = "Frog"
        case funk = "Funk"
        case hero = "Hero"
        case morse = "Morse"
        case purr = "Purr"
        case submarine = "Submarine"
        case tink = "Tink"
        
        var displayName: String {
            switch self {
            case .ding: return "Ding"
            case .bell: return "Bell"
            case .pop: return "Pop"
            case .basso: return "Basso"
            case .blow: return "Blow"
            case .bottle: return "Bottle"
            case .frog: return "Frog"
            case .funk: return "Funk"
            case .hero: return "Hero"
            case .morse: return "Morse"
            case .purr: return "Purr"
            case .submarine: return "Submarine"
            case .tink: return "Tink"
            }
        }
    }
    
    func configure(with settings: SettingsModel) {
        self.settings = settings
    }
    
    // MARK: - Public Sound Methods
    
    func playFocusStartSound() {
        guard settings?.enableSounds ?? false,
              settings?.playSoundOnFocusStart ?? false else { return }
        playSound(type: settings?.soundType ?? "Ping")
    }
    
    func playFocusEndSound() {
        guard settings?.enableSounds ?? false,
              settings?.playSoundOnFocusEnd ?? false else { return }
        playSound(type: settings?.soundType ?? "Ping")
    }
    
    func playBreakStartSound() {
        guard settings?.enableSounds ?? false,
              settings?.playSoundOnBreakStart ?? false else { return }
        playSound(type: settings?.soundType ?? "Ping")
    }
    
    func playBreakEndSound() {
        guard settings?.enableSounds ?? false,
              settings?.playSoundOnBreakEnd ?? false else { return }
        playSound(type: settings?.soundType ?? "Ping")
    }
    
    func playTestSound() {
        playSound(type: settings?.soundType ?? "Ping")
    }
    
    // MARK: - Private Sound Playback
    
    private func playSound(type: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let sound = NSSound(named: type) {
                // Set volume
                let volume = self.settings?.soundVolume ?? 0.5
                sound.volume = Float(volume)
                
                // Play sound
                sound.play()
            } else {
                // Fallback to system beep if sound not found
                NSSound.beep()
            }
        }
    }
}
