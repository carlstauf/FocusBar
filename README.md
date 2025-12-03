# 🍅 FocusBar

<div align="center">

**A minimal, distraction-free Pomodoro timer that lives in your macOS menu bar**

[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://www.apple.com/macos)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

*Stay focused. Work smarter. Achieve more.*

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Architecture](#-architecture)

</div>

---

## 🎯 What is FocusBar?

FocusBar is a **native macOS menu bar application** that implements the Pomodoro Technique — a time management method that uses focused work intervals separated by short breaks. It's designed to be:

- ⚡️ **Lightweight** — Uses < 0.2% CPU, minimal memory footprint
- 🎨 **Native** — Built with SwiftUI, follows macOS design principles
- 🔒 **Private** — No analytics, no tracking, all data stays local
- ⏱ **Accurate** — Drift-proof timer survives system sleep/wake
- 🔔 **Unobtrusive** — Lives in your menu bar, never gets in the way

---

## ✨ Features

### ⏲ **Smart Timer Management**
- **Live Countdown** in menu bar (e.g., `24:58` or `🟢`)
- **Drift-Proof Timing** using wall clock timestamps
- **Auto-Start** next session option
- **Persistent State** survives restarts and system sleep
- **Keyboard Shortcuts** (Space to start/pause)

### 🎨 **Customizable Appearance**
- **Compact Mode** — Show emoji icons instead of time
- **Color-Coded States** — Green for focus, blue for breaks
- **Visual Cycle Tracking** — Red dots show completed Pomodoros
- **Native Design** — Matches macOS Big Sur and later

### 🔔 **Intelligent Notifications**
- Native macOS notifications when sessions complete
- Customizable notification sounds
- Volume control and test button
- Option to disable notifications

### ⚙️ **Flexible Configuration**
| Setting | Range | Default |
|---------|-------|---------|
| Focus Duration | 1-90 min | 25 min |
| Short Break | 1-30 min | 5 min |
| Long Break | 5-60 min | 15 min |
| Long Break Interval | Every N cycles | Every 4 |
| Sound Volume | 0-100% | 60% |

### 🛡 **Advanced Features**
- **Strict Mode** — Disable pause functionality during focus
- **Long Break System** — Automatic long break every 4 completed cycles
- **Cycle Counter** — Track daily productivity with visual indicators
- **Reset to Defaults** — One-click settings reset

---

## 📥 Installation

### Build from Source

#### Prerequisites
- macOS 13 Ventura or later
- Xcode 15 or later
- Apple Developer account (for signing)

#### Steps
```bash
# 1. Clone the repository
git clone https://github.com/yourusername/FocusBar.git
cd FocusBar

# 2. Open in Xcode
open FocusBar.xcodeproj

# 3. Select "My Mac" as the run destination
# (Top toolbar: FocusBar > My Mac)

# 4. Build and run
# Press ⌘R or click the Play button
```

> **Important:** This is a menu bar app — look for it in the **top-right corner** of your screen, not the Dock!

---

## 🚀 Usage

### Quick Start

1. **Launch FocusBar** — Look for `00:00` or `⏱` in your menu bar (top-right corner)
2. **Click the icon** to open the control panel
3. **Press "Start"** (or hit Space) to begin a 25-minute focus session
4. **Work focused** until you hear the completion sound
5. **Take a break** — The timer automatically switches to break mode

### Understanding the Interface

```
┌─────────────────────────────────┐
│         FOCUS SESSION           │ ← Current state
│            25:00                │ ← Time remaining
│         ● ● ● ●                │ ← Completed cycles
├─────────────────────────────────┤
│    ┌─────────────────────┐     │
│    │       START         │     │ ← Primary action
│    └─────────────────────┘     │
├─────────────────────────────────┤
│  [Reset]              [Skip]    │ ← Secondary actions
├─────────────────────────────────┤
│  ⚙️ Settings              Quit  │ ← Footer
└─────────────────────────────────┘
```

### Menu Bar States

| Mode | Display (Normal) | Display (Compact) | Color |
|------|-----------------|-------------------|-------|
| **Idle** | `00:00` | `⏱` | White/Auto |
| **Focus** | `24:58` | `🟢` | Green |
| **Short Break** | `04:59` | `🔵` | Blue |
| **Long Break** | `14:58` | `🔵` | Blue |

### The Pomodoro Flow

```
Start → Focus (25m) → Short Break (5m) → Focus (25m) → Short Break (5m) 
     → Focus (25m) → Short Break (5m) → Focus (25m) → Long Break (15m)
     → [Cycle Resets] → Start again...
```

### Keyboard Shortcuts

- **Space** — Start / Pause / Resume (when panel is open)
- **⌘Q** — Quit the app

---

## 🏗 Architecture

### Tech Stack
- **Language:** Swift 5.9
- **UI Framework:** SwiftUI
- **App Type:** MenuBarExtra (macOS 13+)
- **Persistence:** @AppStorage + UserDefaults
- **Notifications:** UserNotifications framework
- **Sounds:** NSSound (AppKit)

### Project Structure

```
FocusBar/
├── 📱 FocusBarApp.swift              # App entry point
├── 📁 Models/
│   ├── PomodoroTimerModel.swift     # Timer state machine
│   └── SettingsModel.swift          # @AppStorage settings
├── 📁 Views/
│   ├── MenuBarContentView.swift     # Main dropdown panel
│   └── SettingsPopoverView.swift    # Settings interface
├── 📁 Services/
│   ├── SoundService.swift           # Audio playback
│   └── NotificationService.swift    # System notifications
└── 📄 Info.plist                    # App configuration
```

### Design Patterns

- **MVVM** — Separation of UI and business logic
- **Observable Objects** — Reactive state management with `@Published`
- **Dependency Injection** — Services passed to view models
- **Service Layer** — Sound and notification abstractions

### Key Implementation Details

#### Drift-Proof Timer
```swift
// Instead of counting seconds (which drifts):
timer?.fire() // ❌ Accumulates error

// Use wall clock timestamps:
endTime = Date().addingTimeInterval(TimeInterval(timeRemaining))
let remaining = Int(endTime.timeIntervalSinceNow) // ✅ Always accurate
```

#### Sleep/Wake Handling
```swift
NSWorkspace.shared.notificationCenter.addObserver(
    self,
    selector: #selector(handleWake),
    name: NSWorkspace.didWakeNotification,
    object: nil
)
```

---

## 🐛 Troubleshooting

### App doesn't appear in menu bar
- ✅ Check you selected "My Mac" (not "Designed for iPad")
- ✅ Look in the **top-right corner** near the clock
- ✅ Verify build succeeded (no red errors)
- ✅ Try restarting the app

### Notifications not showing
- ✅ Check **System Settings → Notifications → FocusBar**
- ✅ Enable "Allow Notifications"
- ✅ Ensure notifications are enabled in app Settings

### Sounds not playing
- ✅ Check system volume is not muted
- ✅ Enable sounds in app Settings
- ✅ Test with the "Test Sound" button
- ✅ Verify volume slider is > 0%

### Can't pause timer
- ✅ Check if **Strict Mode** is enabled (Settings → Behavior)
- ✅ Strict Mode intentionally disables pausing

---

## 📝 Roadmap

### v1.1 (Next Release)
- [ ] Customizable timer sounds
- [ ] Stats/analytics dashboard
- [ ] Export session history
- [ ] Dark/Light theme toggle

### v2.0 (Future)
- [ ] iCloud sync across devices
- [ ] Shortcuts app integration
- [ ] Apple Watch support
- [ ] Focus mode automation

---

## 📜 License

Copyright © 2025 Carl Stauffer. All rights reserved.

This project is licensed under the MIT License.

---

## 🙏 Acknowledgments

- **Francesco Cirillo** — Creator of the Pomodoro Technique
- **Apple Developer Community** — For SwiftUI resources and inspiration

---

<div align="center">

**⭐️ If FocusBar helps you stay focused, consider giving it a star!**

Made with ❤️ and lots of ☕️

</div>
