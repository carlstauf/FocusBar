//
//  NotificationService.swift
//  FocusBar
//
//  Handles system notifications
//

import Foundation
import UserNotifications
import AppKit

class NotificationService: ObservableObject {
    private var settings: SettingsModel?
    
    init() {
        requestAuthorization()
    }
    
    func configure(with settings: SettingsModel) {
        self.settings = settings
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
        }
    }
    
    func sendNotification(title: String, body: String) {
        guard settings?.notificationsEnabled ?? true else { return }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        if settings?.soundEnabled ?? true {
            content.sound = .default
        }
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
        
        // Optional: Play system sound
        if settings?.soundEnabled ?? true {
            NSSound.beep()
        }
    }
}
