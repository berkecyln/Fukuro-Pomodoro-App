//
//  NotificationManager.swift
//  PomoApp
//
//  Created by Berke Ceylan on 30.07.2023.
//

import Foundation
import UserNotifications

class NotificationManager{
    static let shared = NotificationManager()
    let notificationDelegate = NotificationDelegate()
    
    func requestNotificationPermisson(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
            granted, error in
            if granted == true && error == nil{
                //Permisson Granted
            }
        }
    }
    
    func sendNotification(title: String, body: String, delay: TimeInterval){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        //content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "customSound.wav")) // to add custom sound

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
}
