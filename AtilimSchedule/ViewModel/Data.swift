//
//  Data.swift
//  fetchdata
//
//  Created by Tacettin Pekin on 5.10.2023.
//

import Foundation

class DataClassifier: ObservableObject{
    @Published var welcome: Welcome?
    @Published var courses: [Course] = []
    @Published var isLoading = false
    func getData() {
        isLoading = true
        let tdNum = "29"
        let domain = "https://atilimengr.edupage.org"
        
        let headers = [
            "authority": domain.replacingOccurrences(of: "https://", with: ""),
            "origin": domain,
            "referer": domain,
            "cookie" : "PHPSESSID=3c6a20fde6e9fdae72ad787719a257b1"
        ]
        
        var request = URLRequest(url: URL(string: "\(domain)/timetable/server/regulartt.js?__func=regularttGetData")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = "{\"__args\" : [null,\"\(tdNum)\"],\"__gsh\" : \"00000000\"}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Network request failed: \(error)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response or data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let welcomeData = try decoder.decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    self.welcome = welcomeData
                    self.processData(welcomeData: welcomeData)
//                    self.printCourses(courses: self.courses)
                    self.isLoading = false
                    
                }
            } catch {
                print("Decoding failed: \(error)")
            }
        }
        task.resume()
    }
    
    func processData(welcomeData: Welcome) {
        guard let lessonsTable = welcomeData.r.dbiAccessorRes.tables.first(where: { $0.id == "lessons" }),
              let classroomsTable = welcomeData.r.dbiAccessorRes.tables.first(where: { $0.id == "classrooms" }),
              let subjectsTable = welcomeData.r.dbiAccessorRes.tables.first(where: { $0.id == "subjects" }),
              let periodsTable = welcomeData.r.dbiAccessorRes.tables.first(where: { $0.id == "periods" }),
              let cardsTable = welcomeData.r.dbiAccessorRes.tables.first(where: { $0.id == "cards" }),
              let teachersTable = welcomeData.r.dbiAccessorRes.tables.first(where: { $0.id == "teachers" }),
              let daysDefsTable = welcomeData.r.dbiAccessorRes.tables.first(where: { $0.id == "daysdefs" }) else {
            print("Unable to find necessary tables")
            return
        }
        
        var coursesDictionary: [String: Course] = [:]
        
        for card in cardsTable.dataRows {
            guard let lessonID = card.lessonid,
                  let periodID = card.period,
                  let classroomIDs = card.classroomids,
                  let lessonRow = lessonsTable.dataRows.first(where: { $0.id == lessonID }),
                  let periodRow = periodsTable.dataRows.first(where: { $0.id == periodID }) else {
                continue
            }
            
            var teacherName: String?
            if let teacherIDs = lessonRow.teacherids {
                teacherName = teacherIDs.compactMap { teacherID in
                    teachersTable.dataRows.first(where: { $0.id == teacherID })?.short
                }.first
            }
            
            let classroomNames = classroomIDs.compactMap { classroomID in
                classroomsTable.dataRows.first(where: { $0.id == classroomID })?.name
            }.joined(separator: ", ")
            
            if let subjectID = lessonRow.subjectid,
               let subjectRow = subjectsTable.dataRows.first(where: { $0.id == subjectID }) {
                let subjectName = subjectRow.name ?? ""
                
                // Skip reserved entries
                if subjectName.uppercased().contains("RESERVED") || subjectName.uppercased().contains("REZERVE") || subjectName.uppercased().contains("REZERV") {
                    continue
                }
                
                let subjectComponents = subjectName.split(separator: "-")
                guard subjectComponents.count >= 2 else {
                    print("Unexpected subject format: \(subjectName)")
                    continue
                }
                
                let id = String(subjectComponents[0]).trimmingCharacters(in: .whitespaces)
                let sectionID = String(subjectComponents[1]).trimmingCharacters(in: .whitespaces)
                let name = subjectComponents.dropFirst(2).joined(separator: "-").trimmingCharacters(in: .whitespaces)
                
//                var durationString: String?
//                if let startTimeString = periodRow.starttime, let endTimeString = periodRow.endtime {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "HH:mm"
//                    if let startTime = dateFormatter.date(from: startTimeString), let endTime = dateFormatter.date(from: endTimeString) {
//                        let duration = endTime.timeIntervalSince(startTime)
//                        let durationInMinutes = Int(duration / 60)
//                        // Convert durationInMinutes to your desired format, e.g., "2 periods"
//                        durationString = "\(durationInMinutes) minutes"  // Adjust this line as needed
//                    }
//                }
                
                var dayName: String?
                if let daysEncoded = card.days {
                    // Find the dayRow where vals contains daysEncoded
                    if let dayRow = daysDefsTable.dataRows.first(where: { $0.vals?.contains(daysEncoded) == true }) {
                        dayName = dayRow.name
                    }
                }
                
                var endTimeString: String?
                if let durationPeriods = lessonRow.durationperiods {
                    let lengthOfPeriod = 50
                    let breakBetweenPeriods = 10
                    let totalDurationInMinutes = (durationPeriods * lengthOfPeriod) + ((durationPeriods - 1) * breakBetweenPeriods)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    if let startTimeDate = dateFormatter.date(from: periodRow.starttime ?? "") {
                        if let endTimeDate = Calendar.current.date(byAdding: .minute, value: totalDurationInMinutes, to: startTimeDate) {
                            endTimeString = dateFormatter.string(from: endTimeDate)
                        }
                    }
                }
                
                let teacher = Teacher(name: teacherName ?? "")
                let schedule = Schedule(day: dayName ?? "",  // Make sure dayName is defined in your duration and day processing code
                                        classroom: classroomNames,
                                        period: periodRow.name ?? "",
                                        startTime: periodRow.starttime ?? "",
                                        endTime: endTimeString ?? "",  // Make sure endTimeString is defined in your duration and end time processing code
                                        duration: "\(lessonRow.durationperiods ?? 0) period(s)")
                
                // You might need to create a composite key or use a different approach to ensure uniqueness
                let courseKey = id  // using only the course id as the key, not a composite key

                if var course = coursesDictionary[courseKey] {
                    // Course already exists
                    if let index = course.sections.firstIndex(where: { $0.id == sectionID }) {
                        // Section already exists, update it if necessary
                        course.sections[index].schedules.append(schedule)
                    } else {
                        // Section does not exist, create and append new section
                        let newSection = Sections(id: sectionID, teacher: teacher, schedules: [schedule])
                        course.sections.append(newSection)
                    }
                    coursesDictionary[courseKey] = course  // update the course in the dictionary
                } else {
                    // Course does not exist, create new course and section
                    let section = Sections(id: sectionID, teacher: teacher, schedules: [schedule])
                    let course = Course(id: id, name: name, sections: [section])
                    coursesDictionary[courseKey] = course  // add the new course to the dictionary
                }
            }
        }
        
        self.courses = Array(coursesDictionary.values)
        
    }
    
    func printCourses(courses: [Course]) {
        for course in courses {
            print("Course ID: \(course.id)")
            print("Course Name: \(course.name)")
            print("Sections:")
            for section in course.sections {
                print("  Section ID: \(section.id)")
                print("  Teacher: \(section.teacher.name)")
                print("  Schedules:")
                for schedule in section.schedules {
                    print("    Day: \(schedule.day)")
                    print("    Classroom: \(schedule.classroom)")
                    print("    Period: \(schedule.period)")
                    print("    Start Time: \(schedule.startTime)")
                    print("    End Time: \(schedule.endTime)")
                    print("    Duration: \(schedule.duration)")
                }
            }
            print("--------------------")
        }
    }
    
    
}
