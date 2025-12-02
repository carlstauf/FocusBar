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
            VStack(alignment: .leading, spacing: 14) {
                // Header
                Text("Settings")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                Divider()
                
                // Timer Settings
                VStack(alignment: .leading, spacing: 8) {
                    Label("Timer", systemImage: "timer")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Focus")
                                .font(.caption)
                            Spacer()
                            Text("\(settings.focusLength) min")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .monospacedDigit()
                        }
                        Slider(value: Binding(
                            get: { Double(settings.focusLength) },
                            set: { settings.focusLength = Int($0) }
                        ), in: 1...90, step: 1)
                        
                        HStack {
                            Text("Break")
                                .font(.caption)
                            Spacer()
                            Text("\(settings.breakLength) min")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .monospacedDigit()
                        }
                        Slider(value: Binding(
                            get: { Double(settings.breakLength) },
                            set: { settings.breakLength = Int($0) }
                        ), in: 1...30, step: 1)
                        
                        Toggle("Long Break (every 4)", isOn: $settings.longBreakEnabled)
                            .font(.caption)
                        
                        if settings.longBreakEnabled {
                            HStack {
                                Text("Long Break")
                                    .font(.caption)
                                Spacer()
                                Text("\(settings.longBreakLength) min")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .monospacedDigit()
                            }
                            .padding(.leading, 12)
                            Slider(value: Binding(
                                get: { Double(settings.longBreakLength) },
                                set: { settings.longBreakLength = Int($0) }
                            ), in: 5...60, step: 5)
                            .padding(.leading, 12)
                        }
                        
                        Toggle("Auto-start next", isOn: $settings.autoStart)
                            .font(.caption)
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                
                // Sound Settings
                VStack(alignment: .leading, spacing: 8) {
                    Label("Sound", systemImage: "speaker.wave.2")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Toggle("Enable Sounds", isOn: $settings.enableSounds)
                            .font(.caption)
                        
                        if settings.enableSounds {
                            HStack {
                                Text("Volume")
                                    .font(.caption)
                                Spacer()
                                Text("\(Int(settings.soundVolume * 100))%")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .monospacedDigit()
                                    .frame(width: 35)
                            }
                            .padding(.leading, 12)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "speaker.fill")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Slider(value: $settings.soundVolume, in: 0...1)
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.leading, 12)
                            
                            Button("Test Sound") {
                                let sound = NSSound(named: "Glass")
                                sound?.volume = Float(settings.soundVolume)
                                sound?.play()
                            }
                            .controlSize(.small)
                            .buttonStyle(.bordered)
                            .padding(.leading, 12)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                
                // Notifications
                VStack(alignment: .leading, spacing: 8) {
                    Label("Notifications", systemImage: "bell")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    Toggle("Enable Notifications", isOn: $settings.notificationsEnabled)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                Divider()
                
                // Behavior Settings
                VStack(alignment: .leading, spacing: 8) {
                    Label("Behavior", systemImage: "slider.horizontal.3")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Toggle("Strict Mode", isOn: $settings.strictMode)
                            .font(.caption)
                            .help("Timer cannot be paused")
                        
                        Toggle("End Reminder", isOn: $settings.endOfSessionReminder)
                            .font(.caption)
                            .help("Shows reminder near end of session")
                    }
                    .padding(.horizontal)
                }
                
                // Stats
                if timerModel.completedCycles > 0 {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Today", systemImage: "chart.bar")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Completed")
                                .font(.caption)
                            Spacer()
                            Text("\(timerModel.completedCycles)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                                .monospacedDigit()
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider()
                
                // Reset to Defaults
                Button(action: {
                    settings.resetToDefaults()
                }) {
                    Label("Reset to Defaults", systemImage: "arrow.counterclockwise")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Footer
                Text("Changes save automatically")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 4)
                    .padding(.bottom, 8)
            }
        }
        .frame(width: 340, height: 480)
    }
}

#Preview {
    SettingsPopoverView()
        .environmentObject(SettingsModel())
        .environmentObject(PomodoroTimerModel(
            settings: SettingsModel(),
            notificationService: NotificationService(),
            soundService: SoundService(settings: SettingsModel())
        ))
}
