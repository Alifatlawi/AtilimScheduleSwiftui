//
//  ContentView.swift
//  AtilimSchedule
//
//  Created by Ali Amer on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        Group {
            if currentPage <= totalPages {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
