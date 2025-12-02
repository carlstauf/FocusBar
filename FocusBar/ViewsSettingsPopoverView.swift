//
//  SettingsPopoverView.swift
//  FocusBar
//
//  Settings configuration panel
//

import SwiftUI

struct SettingsPopoverView: View {
    @EnvironmentObject var settings: SettingsModel
    @EnvironmentObject var timerModel: PomodoroTimerModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Text("Settings")
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                    Spacer()
                }
                .padding(.bottom, 4)
                
                // Timer Settings
                GroupBox(label: Label("Timer", systemImage: "timer")) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Focus Duration")
                            Spacer()
                            Text("\(settings.focusLength) min")
                                .foregroundColor(.secondary)
                        }
                        Slider(value: Binding(
                            get: { Double(settings.focusLength) },
                            set: { settings.focusLength = Int($0) }
                        ), in: 1...90, step: 1)
                        
                        HStack {
                            Text("Break Duration")
                            Spacer()
                            Text("\(settings.breakLength) min")
                                .foregroundColor(.secondary)
                        }
                        Slider(value: Binding(
                            get: { Double(settings.breakLength) },
                            set: { settings.breakLength = Int($0) }
                        ), in: 1...30, step: 1)
                        
                        Toggle("Long Break (every 4 cycles)", isOn: $settings.longBreakEnabled)
                        
                        if settings.longBreakEnabled {
                            HStack {
                                Text("Long Break Duration")
                                Spacer()
                                Text("\(settings.longBreakLength) min")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.leading)
                            Slider(value: Binding(
                                get: { Double(settings.longBreakLength) },
                                set: { settings.longBreakLength = Int($0) }
                            ), in: 5...60, step: 5)
                            .padding(.leading)
                        }
                        
                        Toggle("Auto-start next session", isOn: $settings.autoStart)
                    }
                    .padding(.vertical, 4)
                }
                
                // Appearance Settings
                GroupBox(label: Label("Appearance", systemImage: "paintbrush")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Compact Mode (icon only)", isOn: $settings.compactMode)
                        
                        HStack {
                            Text("Menu Bar Color")
                            Spacer()
                            Picker("", selection: $settings.menuBarColor) {
                                Text("Auto").tag("auto")
                                Text("White").tag("white")
                                Text("Red").tag("red")
                                Text("Green").tag("green")
                            }
                            .labelsHidden()
                            .frame(width: 100)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // Sound Settings
                GroupBox(label: Label("Sound", systemImage: "speaker.wave.2")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Enable Sound", isOn: $settings.soundEnabled)
                        
                        if settings.soundEnabled {
                            HStack {
                                Text("Volume")
                                Spacer()
                                Slider(value: $settings.soundVolume, in: 0...1)
                                    .frame(width: 120)
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // Notifications
                GroupBox(label: Label("Notifications", systemImage: "bell")) {
                    Toggle("Enable Notifications", isOn: $settings.notificationsEnabled)
                        .padding(.vertical, 4)
                }
                
                // Behavior Settings
                GroupBox(label: Label("Behavior", systemImage: "slider.horizontal.3")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Strict Mode (no pause)", isOn: $settings.strictMode)
                        Toggle("End of Session Reminder", isOn: $settings.endOfSessionReminder)
                    }
                    .padding(.vertical, 4)
                }
                
                // Stats
                if timerModel.completedCycles > 0 {
                    GroupBox(label: Label("Today", systemImage: "chart.bar")) {
                        HStack {
                            Text("Completed Cycles")
                            Spacer()
                            Text("\(timerModel.completedCycles)")
                                .font(.system(.title3, design: .rounded, weight: .semibold))
                                .foregroundColor(.red)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .padding()
        }
    }
}
