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
    
    private func play(_ name: String) {
        guard settings.enableSounds else { return }
        
        if let sound = NSSound(named: name) {
            sound.volume = Float(settings.soundVolume)
            sound.play()
        }
    }
    
    // MARK: - Public Sound Events
    
    func playFocusStart() {
        play("Glass")     // macOS system sound
    }
    
    func playFocusEnd() {
        play("Hero")      // macOS system sound
    }
    
    func playBreakStart() {
        play("Ping")      // macOS system sound
    }
    
    func playBreakEnd() {
        play("Submarine") // macOS system sound
    }
}
