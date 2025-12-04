# 🚀 FocusBar Quick Start Guide

## Build & Run

### Prerequisites
- macOS 13 Ventura or later
- Xcode 15 or later

### Steps

1. **Open the project**
   ```bash
   open FocusBar.xcodeproj
   ```

2. **Select your Mac as the target**
   - Top toolbar: `FocusBar > My Mac`
   - Make sure it's NOT "Designed for iPad"

3. **Build and Run**
   - Press `⌘R` or click the Play button
   - **Important:** Look for the app in your **menu bar** (top-right corner), not the Dock!

## First Launch

1. **Find the app** - Look for `00:00` or `⏱` in your menu bar
2. **Grant permissions** - Allow notifications when prompted
3. **Click the icon** - Opens the control panel
4. **Press Start** - Begins a 25-minute focus session

## Quick Tips

### Keyboard Shortcuts
- `Space` - Start/Pause (when dropdown is open)
- `⌘Q` - Quit

### Menu Bar States
| State | Normal | Compact | Color |
|-------|--------|---------|-------|
| Idle | 00:00 | ⏱ | White |
| Focus | 24:58 | 🟢 | Green |
| Break | 04:59 | 🔵 | Blue |

### Settings
Click the ⚙️ gear icon to access:
- Timer durations
- Compact mode toggle
- Sound volume
- Strict mode
- Long break settings

## Troubleshooting

### App not in menu bar?
- ✅ Check you selected "My Mac" not iPad
- ✅ Look far right, near clock/battery
- ✅ Try quitting and relaunching

### Timer freezing?
- ✅ Already fixed! Timer uses `.common` run loop mode

### Settings not opening?
- ✅ Already fixed! Opens in separate window now

### Sounds not working?
- ✅ Check System Settings → Sound → Output volume
- ✅ Check in-app Settings → Enable Sounds
- ✅ Use "Test Sound" button

## Files to Clean Up

Before final release, consider deleting:
- `ContentView.swift` - Not used
- `FocusBarApp_NEW.swift` - Old version

## Debug Mode

The app includes debug logging. To see it:
```bash
# Run from Terminal to see console output
open -a FocusBar
# Or run from Xcode to see in debug console
```

Look for messages like:
```
🔄 Focus completed. Cycles: 4, Long break enabled: true, Should take long break: true
```

## Ready to Ship! 🎉

Your app is fully functional and ready to use. Build, test, and enjoy your new Pomodoro timer!

---

**Need help?** Check `IMPLEMENTATION_STATUS.md` for detailed testing checklist and known issues.
