//
//  AtilimScheduleApp.swift
//  AtilimSchedule
//
//  Created by Ali Amer on 10/5/23.
//

import SwiftUI
//import UserNotifications

@main
struct AtilimScheduleApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var sharedData = SharedData.shared
//    init() {
//            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
//                if granted {
//                    print("Notification authorization granted")
//                } else {
//                    print("Notification authorization denied")
//                }
//            }
//        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(sharedData)
        }
    }
}
