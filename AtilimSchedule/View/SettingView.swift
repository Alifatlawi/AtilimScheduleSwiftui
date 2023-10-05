//
//  SettingView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/30/23.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var alarmButton = false
    @State private var selectedTime = "10 min"
    let notificationTimes = ["10 min Before", "20 min Before", "30 min Before"]
    
    var leadTime: Int {
        guard let timeString = selectedTime.split(separator: " ").first,
              let time = Int(timeString) else {
            return 0 // or handle error appropriately
        }
        return time
    }
    
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
                    
                    
                    if alarmButton {
                        Picker(selection: $selectedTime, label: Text("Notification Time")) {
                            ForEach(notificationTimes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                } footer: {
                    Text("Giving you a notification before the class or the exam")
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
                    //                        .offset(x: 200, y: 0)
                    //                        .scaleEffect(0.6)
                )
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    SettingView()
}

