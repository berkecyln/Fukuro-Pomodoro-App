//
//  NotificationDelegate.swift
//  PomoApp
//
//  Created by Berke Ceylan on 30.07.2023.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    // This function will be called right before notification will be presented
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Here you can customize the presentation options of the notification
        // (i.e., if the alert should be shown or sound should be played, or the app should be brought to the foreground)
        completionHandler([.banner, .sound])
    }
    
    // This function will be called when a user interacts with a notification (i.e., taps on it)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Here you can customize what to do when the notification is interacted with
        completionHandler()
    }
}

