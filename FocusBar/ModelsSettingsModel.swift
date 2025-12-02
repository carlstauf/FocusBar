//
//  SettingsModel.swift
//  FocusBar
//
//  Persistent settings using @AppStorage
//

import Foundation
import SwiftUI
import Combine

class SettingsModel: ObservableObject {
    // Timer Settings
    @AppStorage("focusLength") var focusLength: Int = 25 {
        willSet { objectWillChange.send() }
    }
    @AppStorage("breakLength") var breakLength: Int = 5 {
        willSet { objectWillChange.send() }
    }
    @AppStorage("longBreakLength") var longBreakLength: Int = 15 {
        willSet { objectWillChange.send() }
    }
    @AppStorage("longBreakEnabled") var longBreakEnabled: Bool = true {
        willSet { objectWillChange.send() }
    }
    @AppStorage("autoStart") var autoStart: Bool = false {
        willSet { objectWillChange.send() }
    }
    
    // Appearance Settings
    @AppStorage("compactMode") var compactMode: Bool = false {
        willSet { objectWillChange.send() }
    }
    @AppStorage("menuBarColor") var menuBarColor: String = "auto" {
        willSet { objectWillChange.send() }
    }
    @AppStorage("showTimerInMenuBar") var showTimerInMenuBar: Bool = true {
        willSet { objectWillChange.send() }
    }
    
    // Sound Settings
    @AppStorage("enableSounds") var enableSounds: Bool = true {
        willSet { objectWillChange.send() }
    }
    @AppStorage("soundVolume") var soundVolume: Double = 0.6 {
        willSet { objectWillChange.send() }
    }
    
    // Notification Settings
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = true {
        willSet { objectWillChange.send() }
    }
    
    // Behavior Settings
    @AppStorage("strictMode") var strictMode: Bool = false {
        willSet { objectWillChange.send() }
    }
    @AppStorage("endOfSessionReminder") var endOfSessionReminder: Bool = true {
        willSet { objectWillChange.send() }
    }
    
    // MARK: - Reset to Defaults
    
    func resetToDefaults() {
        // Timer Settings
        focusLength = 25
        breakLength = 5
        longBreakLength = 15
        longBreakEnabled = true
        autoStart = false
        
        // Appearance Settings
        compactMode = false
        menuBarColor = "auto"
        showTimerInMenuBar = true
        
        // Sound Settings
        enableSounds = true
        soundVolume = 0.6
        
        // Notification Settings
        notificationsEnabled = true
        
        // Behavior Settings
        strictMode = false
        endOfSessionReminder = true
    }
}
