import SwiftUI
import CoreData

struct ScheduleResultView: View {
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    let fullDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let startHour = 9
    let endHour = 18
    
    @FetchRequest(
        entity: CourseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CourseEntity.name, ascending: true)]
    ) var courses: FetchedResults<CourseEntity>
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let colWidth = width / CGFloat(days.count + 1)
            let totalRows = (endHour - startHour) * 2 + 2
            let rowHeight = (geometry.size.height * 1.8) / CGFloat(totalRows)
            
            HStack(spacing: 0) {
                // Column for hour labels
                VStack(alignment: .trailing, spacing: 0) {
                    // Extra empty cell
                    Text("")
                        .frame(width: colWidth, height: rowHeight)
                        .overlay(
                            Rectangle()
                                .strokeBorder(Color.primary, lineWidth: 0.2)  // Set the lineWidth to your desired border width
                        )
                    
                    ForEach(startHour..<endHour, id: \.self) { hour in
                        Text("\(hour):30")
                            .frame(width: colWidth, height: rowHeight)
                            .overlay(
                                Rectangle()
                                    .strokeBorder(Color.primary, lineWidth: 0.2)  // Set the lineWidth to your desired border width
                            )
                    }
                }
                
                // Columns for each day
                ForEach(days.indices, id: \.self) { index in
                    VStack(spacing: 0) {
                        Text(days[index])
                            .frame(width: colWidth, height: rowHeight)
                            .background(Color.gray.opacity(0.2))
                            .overlay(
                                Rectangle()
                                    .strokeBorder(Color.primary, lineWidth: 0.2)  // Set the lineWidth to your desired border width
                            )
                        
                        ForEach(startHour..<endHour, id: \.self) { hour in
                            courseView(for: days[index], hour: hour, minute: 30)
                                .frame(width: colWidth, height: rowHeight)
                                .overlay(
                                    Rectangle()
                                        .strokeBorder(Color.primary, lineWidth: 0.2)  // Set the lineWidth to your desired border width
                                )
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
    
    func courseView(for day: String, hour: Int, minute: Int) -> some View {
        var color: Color {
            // Assuming you have a property 'courseColor' in CourseEntity
            Color(hex: courseInfo?.course.color ?? "#000000")
        }
        let courseInfo = schedule(for: day, hour: hour, minute: minute)
        return AnyView(
            ZStack {
                Rectangle()
                    .fill(courseInfo != nil ? color : Color.clear)
                VStack {
                    Text(courseInfo?.course.id ?? "")
                        .font(.footnote)
                    Text(courseInfo?.schedule.classroom ?? "")
                        .font(.footnote)
                }
            }
        )
    }
    
    func schedule(for day: String, hour: Int, minute: Int) -> (course: CourseEntity, schedule: ScheduleEntity)? {
        guard let dayIndex = days.firstIndex(of: day), dayIndex < fullDays.count else { return nil }
        let fullDayName = fullDays[dayIndex]
        
        for course in courses {
            for section in (course.sections?.allObjects as? [SectionEntity] ?? []) {
                for schedule in (section.schedules?.allObjects as? [ScheduleEntity] ?? []) {
                    if schedule.day == fullDayName && isTimeWithinSchedule(hour: hour, minute: minute, schedule: schedule) {
                        return (course, schedule)
                    }
                }
            }
        }
        return nil
    }
    
    func isTimeWithinSchedule(hour: Int, minute: Int, schedule: ScheduleEntity) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        guard let startTime = formatter.date(from: schedule.startTime ?? ""),
              let endTime = formatter.date(from: schedule.endTime ?? "") else {
            return false
        }
        
        let currentDate = formatter.date(from: "\(hour):\(minute < 10 ? "0\(minute)" : "\(minute)")")
        
        return (startTime...endTime).contains(currentDate!)
    }
}


extension Schedule {
    var startsAtHour: Int {
        let hourString = String(startTime.prefix(2))
        return Int(hourString) ?? 0
    }
    
    var durationInHalfHours: Int {
        // Assuming startTime and endTime are in "HH:mm" format
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let start = formatter.date(from: startTime),
              let end = formatter.date(from: endTime) else {
            return 0
        }
        let duration = end.timeIntervalSince(start)
        return Int(duration / 1800)  // Convert seconds to half-hours
    }
}

#Preview {
    ScheduleResultView()
}




