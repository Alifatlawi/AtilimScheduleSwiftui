//
//  AtilimScheduleApp.swift
//  AtilimSchedule
//
//  Created by Ali Amer on 10/5/23.
//

import SwiftUI

@main
struct AtilimScheduleApp: App {
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
