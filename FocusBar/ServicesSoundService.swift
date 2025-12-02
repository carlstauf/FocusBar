//
//  SoundService.swift
//  FocusBar
//
//  Handles sound playback for timer events
//

import Foundation
import AppKit

class SoundService {
    private var settings: SettingsModel
    
    init(settings: SettingsModel) {
        self.settings = settings
    }
    
    // MARK: - Public Methods
    
    func playFocusStartSound() {
        guard settings.enableSounds, settings.playSoundOnFocusStart else { return }
        playSound(named: settings.soundType, volume: settings.soundVolume)
    }
    
    func playFocusEndSound() {
        guard settings.enableSounds, settings.playSoundOnFocusEnd else { return }
        playSound(named: settings.soundType, volume: settings.soundVolume)
    }
    
    func playBreakStartSound() {
        guard settings.enableSounds, settings.playSoundOnBreakStart else { return }
        playSound(named: settings.soundType, volume: settings.soundVolume)
    }
    
    func playBreakEndSound() {
        guard settings.enableSounds, settings.playSoundOnBreakEnd else { return }
        playSound(named: settings.soundType, volume: settings.soundVolume)
    }
    
    func playTestSound() {
        playSound(named: settings.soundType, volume: settings.soundVolume)
    }
    
    // MARK: - Private Methods
    
    private func playSound(named soundName: String, volume: Double) {
        let clampedVolume = Float(min(max(volume, 0.0), 1.0))
        
        // Try to load the specified sound
        if let sound = NSSound(named: soundName) {
            sound.volume = clampedVolume
            sound.play()
            return
        }
        
        // Fallback to system sounds
        switch soundName {
        case "ding", "default":
            if let sound = NSSound(named: "Ping") {
                sound.volume = clampedVolume
                sound.play()
            } else {
                NSSound.beep()
            }
        case "bell":
            if let sound = NSSound(named: "Glass") {
                sound.volume = clampedVolume
                sound.play()
            } else {
                NSSound.beep()
            }
        case "pop":
            if let sound = NSSound(named: "Pop") {
                sound.volume = clampedVolume
                sound.play()
            } else {
                NSSound.beep()
            }
        default:
            NSSound.beep()
        }
    }
}
