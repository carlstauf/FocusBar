//
//  MenuBarContentView.swift
//  FocusBar
//
//  Main dropdown panel UI
//

import SwiftUI

struct MenuBarContentView: View {
    @EnvironmentObject var timerModel: PomodoroTimerModel
    @EnvironmentObject var settings: SettingsModel
    @State private var showSettings = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Main timer section
            VStack(spacing: 12) {
                // State label
                Text(timerModel.state.displayName)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                
                // Timer display
                Text(timerModel.timeString)
                    .font(.system(size: 48, weight: .thin, design: .rounded))
                    .monospacedDigit()
                    .foregroundColor(stateColor)
                
                // Cycle counter
                if timerModel.completedCycles > 0 {
                    HStack(spacing: 4) {
                        ForEach(0..<min(timerModel.completedCycles, 8), id: \.self) { _ in
                            Circle()
                                .fill(Color.red.opacity(0.8))
                                .frame(width: 6, height: 6)
                        }
                        if timerModel.completedCycles > 8 {
                            Text("+\(timerModel.completedCycles - 8)")
                                .font(.system(.caption2, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)
            .background(Color(nsColor: .controlBackgroundColor))
            
            Divider()
            
            // Controls section
            VStack(spacing: 10) {
                // Primary action button
                Button(action: primaryAction) {
                    Text(primaryButtonLabel)
                        .font(.system(.body, design: .rounded, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .tint(stateColor)
                .disabled(timerModel.isRunning && settings.strictMode)
                .keyboardShortcut(.space, modifiers: [])
                
                // Secondary actions
                HStack(spacing: 8) {
                    Button("Reset") {
                        timerModel.reset()
                    }
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    
                    if timerModel.state != .idle {
                        Button("Skip") {
                            timerModel.skip()
                        }
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(12)
            
            Divider()
            
            // Footer
            HStack {
                Button(action: { showSettings.toggle() }) {
                    Label("Settings", systemImage: "gearshape")
                        .font(.system(.caption, design: .rounded))
                }
                .buttonStyle(.plain)
                .foregroundColor(.secondary)
                .popover(isPresented: $showSettings) {
                    SettingsPopoverView()
                        .environmentObject(settings)
                        .environmentObject(timerModel)
                        .frame(width: 320, height: 500)
                }
                
                Spacer()
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .foregroundColor(.secondary)
                .font(.system(.caption, design: .rounded))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .frame(width: 280)
    }
    
    // MARK: - Computed Properties
    
    private var primaryButtonLabel: String {
        if timerModel.isPaused {
            return "Resume"
        } else if timerModel.isRunning {
            return settings.strictMode ? "Running..." : "Pause"
        } else {
            return "Start"
        }
    }
    
    private func primaryAction() {
        if timerModel.isPaused {
            timerModel.resume()
        } else if timerModel.isRunning {
            timerModel.pause()
        } else {
            timerModel.start()
        }
    }
    
    private var stateColor: Color {
        switch timerModel.state {
        case .idle:
            return .primary
        case .focus:
            return .red
        case .shortBreak, .longBreak:
            return .green
        }
    }
}
