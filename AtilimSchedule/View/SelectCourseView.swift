//
//  SelectCourseView.swift
//  AtilimSchedule
//
//  Created by Tacettin Pekin on 8.10.2023.
//

import SwiftUI

struct SelectCourseView: View {
    @State private var selectedView = 1

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select View", selection: $selectedView) {
                    Text("Weekly").tag(0)
                    Text("Daily").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                if selectedView == 0 {
                    ScheduleResultView()
                } else {
                    ScheduleView()
                }
            }
        }
    }
}

#Preview {
    SelectCourseView()
}
