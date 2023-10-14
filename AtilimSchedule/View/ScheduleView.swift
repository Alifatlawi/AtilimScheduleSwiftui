import SwiftUI
import CoreData

struct ScheduleView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var selectedDay: String = {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
    }()  // Default to Monday
   
    var body: some View {
//        let screenSize = UIScreen.main.bounds.size
        VStack {
            Text(formattedDate)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(.top)
            
            DaySelectionView(selectedDay: $selectedDay)
//                .padding(.vertical)
            
            HeaderRow()
                .background(Color.gray.opacity(0.1))
                
            
            CourseListView(selectedDay: selectedDay)
        }
        .padding(.horizontal)
//        .padding(.bottom, screenSize.height * 0.08)
    }
    
    var formattedDate: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}

struct DaySelectionView: View {
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    @Binding var selectedDay: String
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                Text(String(day.prefix(3)))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .font(.footnote)
                    .dynamicTypeSize(.xxLarge)
                    .background(self.selectedDay == day ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(self.selectedDay == day ? Color.white : Color.blue)
                    .cornerRadius(8)
                    .onTapGesture {
                        self.selectedDay = day
                    }
            }
        }
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
        .padding(.horizontal, 30)
        .foregroundColor(Color.gray)
        .cornerRadius(10)
    }
}

struct CourseListView: View {
    var selectedDay: String
    @FetchRequest(
        entity: CourseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CourseEntity.name, ascending: true)]
    ) var courses: FetchedResults<CourseEntity>
    
    var filteredSchedules: [ScheduleEntity] {
        let allSections = courses.flatMap { course in
            course.sections?.allObjects as? [SectionEntity] ?? []
        }
        let allSchedules = allSections.flatMap { section in
            section.schedules?.allObjects as? [ScheduleEntity] ?? []
        }
        let schedulesForSelectedDay = allSchedules.filter { $0.day == selectedDay }
        
        return schedulesForSelectedDay.sorted {
            guard let startTime1 = $0.startTime, let startTime2 = $1.startTime else {
                return false
            }
            return startTime1 < startTime2
        }
    }
    
    let screenSize = UIScreen.main.bounds.size
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(filteredSchedules, id: \.self) { schedule in  // Changed id to \.self for uniqueness
                            if let course = schedule.section?.course, let section = schedule.section {
                                CourseRowView(course: course, section: section, schedule: schedule)
                            }
                        }
                    }
                    .padding(.bottom, screenSize.height * 0.07)
                }
            }
            .padding(.bottom)
        }
    }
}


struct CourseRowView: View {
    var course: CourseEntity
    var section: SectionEntity
    var schedule: ScheduleEntity
    
    var color: Color {
        // Assuming you have a property 'courseColor' in CourseEntity
        Color(hex: course.color ?? "#000000")
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Image(systemName: "clock")
                VStack {
                    Text(schedule.startTime ?? "")
                    Text(schedule.endTime ?? "")
                        .foregroundStyle(.secondary)
                }
                .padding(.trailing)
                
                Divider()
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(course.name ?? "")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text(course.id ?? "")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("Sec - \(section.id ?? "")")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    HStack {
                        // Assuming you have a property 'classroom' in ScheduleEntity
                        Text("Class: \(schedule.classroom ?? "")")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                .background(color)
                .cornerRadius(12)
            }
            
        }
        .frame(height: 100)
        .padding(.vertical)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
