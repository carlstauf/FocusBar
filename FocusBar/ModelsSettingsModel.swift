//
//  SettingsModel.swift
//  FocusBar
//
//  Persistent settings using @AppStorage
//

import Foundation
import SwiftUI

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
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("soundType") var soundType: String = "ding"
    @AppStorage("soundVolume") var soundVolume: Double = 0.5
    
    // Notification Settings
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = true
    
    // Behavior Settings
    @AppStorage("strictMode") var strictMode: Bool = false
    @AppStorage("endOfSessionReminder") var endOfSessionReminder: Bool = true
}
