//import SwiftUI
//
//struct MakeScheduleView: View {
//    @ObservedObject var dataClassifier = DataClassifier()
//    @ObservedObject var scheduleGenerator = ScheduleGeneratorViewModel()
//    @State private var selectedCourses: [Course] = []
//    @State private var searchText: String = ""
//    @State private var showingScheduleResult = false
//    
//    var filteredCourses: [Course] {
//        if searchText.isEmpty {
//            return dataClassifier.courses
//        } else {
//            return dataClassifier.courses.filter { $0.id.lowercased().contains(searchText.lowercased()) }
//        }
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                List(filteredCourses, id: \.id) { course in
//                    Button(action: {
//                        self.toggleSelection(course: course)
//                    }) {
//                        HStack {
//                            Text(course.id)
//                            Spacer()
//                            Image(systemName: selectedCourses.contains(where: { $0.id == course.id }) ? "minus" : "plus")
//                        }
//                    }
//                }
//                Button("Generate Schedule") {
//                    scheduleGenerator.selectedCourses = self.selectedCourses
//                    scheduleGenerator.generateAllPossibleSchedules()
//                    self.showingScheduleResult = true
//                }
//            }
//            .sheet(isPresented: $showingScheduleResult) {
//                ScheduleResultView(schedules: scheduleGenerator.validSchedules)
//            }
//            .navigationTitle("You added \(selectedCourses.count) courses")
//        }
//        .onAppear {
//            dataClassifier.getData()
//        }
//        .searchable(text: $searchText)
//        
//    }
//    
//    func toggleSelection(course: Course) { // Moved inside the struct
//        if let index = selectedCourses.firstIndex(where: { $0.id == course.id }) {
//            selectedCourses.remove(at: index)
//        } else {
//            selectedCourses.append(course)
//        }
//    }
//}
//
//struct MakeScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        MakeScheduleView()
//    }
//}
