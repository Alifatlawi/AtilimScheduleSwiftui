//import SwiftUI
//
//struct ScheduleResultView: View {
//    var schedules: [[Sections]]
//    @State private var selectedScheduleIndex: Int = 0
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Picker("Select Schedule", selection: $selectedScheduleIndex) {
//                    ForEach(0..<schedules.count) { index in
//                        Text("Schedule \(index + 1)").tag(index)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//
//                ScrollView {
//                    ForEach(daysOfWeek, id: \.self) { day in
//                        DayView(day: day, sections: filterSectionsByDay(day: day, sections: schedules[selectedScheduleIndex]))
//                    }
//                }
//            }
//            .navigationTitle("Generated Schedules")
//        }
//    }
//    
//    // You would need to define your days of the week based on your schedule data
//    var daysOfWeek: [String] {
//        ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
//    }
//    
//    func filterSectionsByDay(day: String, sections: [Sections]) -> [Sections] {
//        // Implement the actual filtering logic to return sections that match the given day
//        // This is a simplified placeholder
//        return sections.filter { section in
//            section.schedules.contains { $0.day == day }
//        }
//    }
//}
//
//struct DayView: View {
//    var day: String
//    var sections: [Sections]
//    
//    var body: some View {
//        VStack {
//            Text(day).font(.headline)
//            
//            ForEach(sortedSections, id: \.id) { section in
//                SectionCardView(section: section)
//            }
//        }
//    }
//    
//    var sortedSections: [Sections] {
//        sections.sorted { $0.schedules.first! < $1.schedules.first! }
//    }
//}
//
//struct SectionCardView: View {
//    var section: Sections
//    
//    var body: some View {
//        VStack {
//            Text("\(section.id) - \(section.teacher.name)")
//            // Add more details about the section as needed
//        }
//        .padding()
//        .background(Color.blue)
//        .cornerRadius(8)
//        .foregroundColor(.white)
//    }
//}
//
//
//extension Schedule: Comparable {
//    static func < (lhs: Schedule, rhs: Schedule) -> Bool {
//        guard let lhsDate = lhs.dateFromStartTime, let rhsDate = rhs.dateFromStartTime else {
//            return false
//        }
//        return lhsDate < rhsDate
//    }
//    
//    var dateFromStartTime: Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm" // Adjust this format to match your time string format
//        return formatter.date(from: self.startTime)
//    }
//}
