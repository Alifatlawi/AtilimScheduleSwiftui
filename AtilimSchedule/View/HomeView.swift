//
//  HomeView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/28/23.
//

import SwiftUI



struct HomeView: View {
    @State private var selectedTab : Tab = .calendar
    
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
                            SelectCourseView()
                            Text("test")
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
