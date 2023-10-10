//
//  SettingView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/30/23.
//

import SwiftUI
import CoreData

struct SettingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var alarmButton: Bool = UserDefaults.standard.bool(forKey: "AlarmButtonState")
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                Section {
                    Toggle(isOn: $alarmButton, label: {
                        HStack{
                            Image(systemName: "alarm")
                            Text("Notification")
                        }
                    })
                    .onChange(of: alarmButton) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "AlarmButtonState")
                        scheduleNotification()
                    }
                    

                } footer: {
                    Text("Giving you a notification 10 before the class")
                }
            }
            .navigationTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    var profile : some View {
        VStack(spacing: 8) {
            Image(.setting)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .background(
                    HexagonView()
                        .offset(x:-50, y: -100)
                )
                .background(
                    BlobView()
                )
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()  // Remove previous notifications

        if alarmButton {
            // Assume you have a method to get today's classes
            let todaysClasses = getTodaysClasses()
            print("working")
            for classItem in todaysClasses {
                        guard let classStartTimeString = classItem.startTime,
                              let classStartTime = dateFromString(classStartTimeString) else { continue }
                        
                        let notificationTime = classStartTime.addingTimeInterval(-600)  // 600 seconds = 10 minutes

                let content = UNMutableNotificationContent()
                content.title = "Class Reminder"
                content.body = "Your \(classItem.id) class is starting soon!"
                
                let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationTime)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

                let request = UNNotificationRequest(identifier: "ClassReminder-\(classItem.id)", content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("Error scheduling notification: \(error)")
                    } else {
                        print("Notification for \(classItem.id) scheduled successfully!")
                    }
                }
            }
        }
    }

    func getTodaysClasses() -> [ScheduleEntity] {
        // Assume ScheduleEntity has a property 'day' to indicate the day of the class
        // And a property 'startTime' to indicate the start time of the class

        let request: NSFetchRequest<ScheduleEntity> = ScheduleEntity.fetchRequest()

        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"  // Day of the week
        let todayString = dateFormatter.string(from: today)

        request.predicate = NSPredicate(format: "day == %@", todayString)

        do {
            let todaysClasses = try viewContext.fetch(request)
            return todaysClasses
        } catch {
            print("Error fetching classes for today: \(error)")
            return []
        }
    }

    func dateFromString(_ timeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.date(from: timeString)
    }


}

#Preview {
    SettingView()
}

