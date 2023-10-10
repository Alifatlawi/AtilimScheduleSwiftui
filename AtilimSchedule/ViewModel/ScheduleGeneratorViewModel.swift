////
////  ScheduleGeneratorViewModel.swift
////  AtilimSchedule
////
////  Created by Ali Amer on 10/6/23.
////
//
//import Foundation
//
//class ScheduleGeneratorViewModel: ObservableObject {
//    @Published var selectedCourses: [Course] = []
//    @Published var validSchedules: [[Sections]] = []
//
//    // ... other properties ...
//
//    func generateAllPossibleSchedules() {
//        let allPossibleSchedules = generateAllPossibleSchedules(from: selectedCourses)
//        validSchedules = allPossibleSchedules.filter { !hasTimeConflict($0) }
//    }
//
//    func generateAllPossibleSchedules(from courses: [Course]) -> [[Sections]] {
//        let allSections = courses.map { $0.sections }
//        return generateCombinations(from: allSections)
//    }
//
//    func generateCombinations(from sectionsList: [[Sections]]) -> [[Sections]] {
//        guard !sectionsList.isEmpty else { return [[]] }
//        
//        var result: [[Sections]] = []
//        var remainder = sectionsList
//        let first = remainder.removeFirst()
//        
//        for section in first {
//            for combination in generateCombinations(from: remainder) {
//                result.append([section] + combination)
//            }
//        }
//        
//        return result
//    }
//    
//    func hasTimeConflict(_ sections: [Sections]) -> Bool {
//        for i in 0..<sections.count {
//            for j in i+1..<sections.count {
//                if sectionsOverlap(sections[i], sections[j]) {
//                    return true
//                }
//            }
//        }
//        return false
//    }
//
//    func sectionsOverlap(_ section1: Sections, _ section2: Sections) -> Bool {
//        for schedule1 in section1.schedules {
//            for schedule2 in section2.schedules {
//                if schedule1.day == schedule2.day && timeOverlap(schedule1, schedule2) {
//                    return true
//                }
//            }
//        }
//        return false
//    }
//
//    func timeOverlap(_ schedule1: Schedule, _ schedule2: Schedule) -> Bool {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        
//        guard let startTime1 = dateFormatter.date(from: schedule1.startTime),
//              let endTime1 = dateFormatter.date(from: schedule1.endTime),
//              let startTime2 = dateFormatter.date(from: schedule2.startTime),
//              let endTime2 = dateFormatter.date(from: schedule2.endTime) else {
//            // Handle error: One of the time strings is not in the expected format
//            print("Error: Unable to convert time string to Date")
//            return false
//        }
//        
//        return (startTime1...endTime1).overlaps(startTime2...endTime2)
//    }
//
//    
//    func generateValidSchedules(from selectedCourses: [Course]) -> [[Sections]] {
//        let allPossibleSchedules = generateAllPossibleSchedules(from: selectedCourses)
//        return allPossibleSchedules.filter { !hasTimeConflict($0) }
//    }
//
//
//}
