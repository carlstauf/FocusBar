# FocusBar - macOS Menu Bar Pomodoro Timer

A beautifully simple menu bar timer that keeps you focused with almost zero interaction and an elegantly invisible presence.

## Overview

FocusBar is a lightweight macOS menu bar app designed to help users maintain focus with minimal friction. It lives entirely in your menu bar - always available, never intrusive, and visually aligned with macOS design principles.

## Features

### Core Features
- **Menu Bar Timer**: Live countdown display directly in your menu bar (e.g., "24:58")
- **Drift-Proof Timer**: Uses wall clock timestamps for perfect accuracy across sleep/wake cycles
- **Multiple Timer States**: Focus sessions, short breaks, and long breaks
- **Auto-Start**: Optionally auto-start the next session
- **Persistent State**: Survives app restarts, system sleep, and reboots
- **System Notifications**: Native macOS notifications for session completions
- **Cycle Tracking**: Visual dots showing completed Pomodoro cycles

### Appearance Options
- **Compact Mode**: Show icon-only (🔴 for focus, 🟢 for break)
- **Menu Bar Colors**: Auto, white, red, or green
- **Clean UI**: Translucent macOS-native styling with smooth animations

### Customization
- **Focus Duration**: 1-90 minutes (default: 25)
- **Break Duration**: 1-30 minutes (default: 5)
- **Long Break**: Optional long break every 4 cycles (default: 15 minutes)
- **Strict Mode**: Disable pause functionality
- **Sound Controls**: Toggle sounds and adjust volume
- **Notifications**: Toggle completion alerts

## How to Build & Run

### Requirements
- macOS 13 Ventura or later
- Xcode 15 or later

### Steps

1. **Open the project in Xcode**
   ```bash
   open FocusBar.xcodeproj
   ```

2. **Select "My Mac" as the run destination**
   - At the top of Xcode, click the device selector dropdown
   - Choose "My Mac" (not "My Mac (Designed for iPad)")

3. **Run the app**
   - Press ⌘ + R (Command + R), OR
   - Click the ▶️ Play button in the top-left toolbar

4. **Find your app**
   - Look in the **top-right corner of your screen** near the clock
   - You'll see "00:00" or a timer icon
   - Click it to open the dropdown panel

### Important: This is a Menu Bar App
- The app will NOT appear in the Dock
- The app will NOT open a window
- Look for it in the **menu bar only** (top-right of screen)

## Usage

### Starting a Focus Session
1. Click the menu bar timer
2. Click "Start"
3. The timer begins counting down
4. The menu bar shows live updates

### Controls
- **Space Bar**: Start/Pause (when dropdown is open)
- **Reset**: Stop and reset to idle state
- **Skip**: Skip to the next session (break or focus)
- **Settings**: Configure all preferences
- **Quit**: Exit the app

### Notifications
- When a focus session completes, you'll get a notification
- When a break ends, you'll be notified to start again
- Click the notification to return to the app

### Cycle Tracking
- Red dots appear showing completed Pomodoro cycles
- After 4 cycles (if enabled), you get a longer break
- Cycles reset when you reset the timer

## Technical Details

### Architecture
- **Pattern**: MVVM (Model-View-ViewModel)
- **Language**: Swift 5.7+
- **UI Framework**: SwiftUI with MenuBarExtra
- **Persistence**: UserDefaults and @AppStorage
- **Notifications**: UserNotifications framework

### File Structure
```
FocusBar/
├── FocusBarApp.swift              # Main app entry point
├── Models/
│   ├── PomodoroTimerModel.swift   # Timer logic and state
│   └── SettingsModel.swift        # Persistent settings
├── Views/
│   ├── MenuBarContentView.swift   # Dropdown panel UI
│   └── SettingsPopoverView.swift  # Settings interface
├── Services/
│   └── NotificationService.swift  # System notifications
└── Info.plist                     # App configuration
```

### Key Technical Features
- **Drift-Proof Timer**: Uses `Date().addingTimeInterval()` instead of counting seconds
- **Sleep/Wake Handling**: Listens to `NSWorkspace.didWakeNotification`
- **State Persistence**: Automatically saves timer state to survive restarts
- **Low CPU Usage**: Updates UI only once per second, < 0.2% CPU

## Customization

### Timer Durations
Open Settings → Timer section to adjust:
- Focus: 1-90 minutes
- Break: 1-30 minutes
- Long Break: 5-60 minutes (every 4 cycles)

### Appearance
Open Settings → Appearance section to:
- Enable compact mode (icon only)
- Change menu bar color
- Toggle timer visibility

### Behavior
Open Settings → Behavior section to:
- Enable strict mode (no pausing)
- Toggle end of session reminders
- Enable/disable auto-start

## Troubleshooting

### App doesn't appear after running
- Make sure you selected "My Mac" (not "Designed for iPad")
- Look in the **menu bar** (top-right of screen), not the Dock
- Check that the build succeeded (no red errors in Xcode)

### Timer isn't accurate
- The timer uses wall clock timestamps and is always accurate
- If you see drift, restart the app

### Notifications not showing
- Check System Settings → Notifications → FocusBar
- Enable notifications in the app Settings

### App won't build
- Make sure you're running macOS 13+ and Xcode 15+
- Check that all files are added to the target

## License

Copyright © 2025 Carl Stauffer. All rights reserved.

## Credits

Built with SwiftUI and love for focused work.
