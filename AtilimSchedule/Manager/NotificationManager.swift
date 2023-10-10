////
////  NotificationManager.swift
////  AtilimSchedule
////
////  Created by Tacettin Pekin on 10.10.2023.
////
//
//import Foundation
//import UserNotifications
//
//class NotificationManager {
//    static let insatance = NotificationManager()
//    
//    func requestAuthorization() {
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
//            if let error = error {
//                print("ERROR \(error)")
//            } else {
//                print("SUCCESS")
//            }
//        }
//    }
//    
//    func scheduleNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "This is test notification!!"
//        content.subtitle = "your class will start soon!"
//        content.sound = .default
//        content.badge = 1
//        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 21
//        dateComponents.minute = 13
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString,
//                                            content: content,
//                                            trigger: trigger)
//    }
//}
