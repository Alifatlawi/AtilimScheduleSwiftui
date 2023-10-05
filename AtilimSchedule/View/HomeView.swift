//
//  HomeView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/28/23.
//

import SwiftUI



struct HomeView: View {
    @State private var selectedTab : Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack{
            
            VStack {
                TabView(selection: $selectedTab,
                        content:  {
                    ForEach(Tab.allCases, id: \.rawValue){ tab in
                        switch selectedTab {
                        case .house:
                            MainView()
                        case .calendar:
                            ScheduleView()
                        case .gearshape:
                            SettingView()
                        case .link:
                            LinkView()
                        }
                    }
                })
            }
            
            
            VStack {
                Spacer()
                CustomeTabBar(selectedTab: $selectedTab)
                    
            }
            .padding(.bottom)
            .ignoresSafeArea(edges: .bottom)
        }
        
    }
}

#Preview {
    HomeView()
}



let sampleCourses = [
    Courses(startTime: "9:30", endTime: "10:20",title: "Computer programming", section: "3", location: "B1010", code: "CMPE113", bgColor: .green),
    // ... other courses ...
]
let sampleSchedule = ["Mon": sampleCourses, /* ... other days ... */]
