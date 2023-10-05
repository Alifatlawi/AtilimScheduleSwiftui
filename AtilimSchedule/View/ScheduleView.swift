//
//  NewScheduleView.swift
//  AtilimSchedule
//
//  Created by Tacettin Pekin on 6.10.2023.
//

import SwiftUI
import CoreData



struct ScheduleView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            DaySelectionView(selectedDay: .constant("Pazartesi"))  // Placeholder
            HeaderRow()
            CourseListView()
        }
        .padding()
    }
}

struct HeaderRow: View {
    var body: some View {
        HStack {
            Text("Time")
                .fontWeight(.medium)
            Spacer()
            Text("Course")
                .fontWeight(.medium)
            Spacer()
        }
        .foregroundColor(Color.gray)
    }
}

struct CourseListView: View {
    @FetchRequest(
        entity: CourseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CourseEntity.name, ascending: true)]
    ) var courses: FetchedResults<CourseEntity>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(courses, id: \.id) { course in
                    ForEach(course.sections?.allObjects as? [SectionEntity] ?? [], id: \.id) { section in
                        ForEach(section.schedules?.allObjects as? [ScheduleEntity] ?? [], id: \.startTime) { schedule in
                            CourseRowView(course: course, section: section, schedule: schedule)
                        }
                    }
                }
            }
        }
    }
}

struct CourseRowView: View {
    var course: CourseEntity
    var section: SectionEntity
    var schedule: ScheduleEntity
    
    var body: some View {
        HStack {
            VStack {
                Text(schedule.startTime ?? "")
                Text(schedule.endTime ?? "")
            }
            Divider()
            VStack(alignment: .leading) {
                Text(course.name ?? "")
                    .fontWeight(.semibold)
                Text(course.id ?? "")
                    .fontWeight(.semibold)
                Text("Section: \(section.id ?? "")")
                    .fontWeight(.semibold)
                Text("Teacher: \(section.teacher?.name ?? "")")
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct DaySelectionView: View {
    let days = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi"]
    @Binding var selectedDay: String?
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in  // Modified line
                Text(String(day.prefix(2)))  // Modified line
                    .padding()
                    .background(self.selectedDay == day ? Color.blue : Color.gray.opacity(0.2))  // Modified line
                    .foregroundColor(self.selectedDay == day ? Color.white : Color.blue)  // Modified line
                    .cornerRadius(8)
                    .onTapGesture {
                        self.selectedDay = day  // Modified line
                    }
            }
        }
    }
}





#Preview {
    ScheduleView()
}
