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
    @AppStorage("focusLength") var focusLength: Int = 25
    @AppStorage("breakLength") var breakLength: Int = 5
    @AppStorage("longBreakLength") var longBreakLength: Int = 15
    @AppStorage("longBreakEnabled") var longBreakEnabled: Bool = true
    @AppStorage("autoStart") var autoStart: Bool = false
    
    // Appearance Settings
    @AppStorage("compactMode") var compactMode: Bool = false
    @AppStorage("menuBarColor") var menuBarColor: String = "auto"
    @AppStorage("showTimerInMenuBar") var showTimerInMenuBar: Bool = true
    
    // Sound Settings
    @AppStorage("enableSounds") var enableSounds: Bool = true
    @AppStorage("soundType") var soundType: String = "Ping"
    @AppStorage("soundVolume") var soundVolume: Double = 0.5
    @AppStorage("playSoundOnFocusStart") var playSoundOnFocusStart: Bool = true
    @AppStorage("playSoundOnFocusEnd") var playSoundOnFocusEnd: Bool = true
    @AppStorage("playSoundOnBreakStart") var playSoundOnBreakStart: Bool = true
    @AppStorage("playSoundOnBreakEnd") var playSoundOnBreakEnd: Bool = true
    
    // Notification Settings
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = true
    
    // Behavior Settings
    @AppStorage("strictMode") var strictMode: Bool = false
    @AppStorage("endOfSessionReminder") var endOfSessionReminder: Bool = true
}
