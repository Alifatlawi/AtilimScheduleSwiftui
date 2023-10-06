//
//  CoursesView.swift
//  AtilimSchedule
//
//  Created by Tacettin Pekin on 5.10.2023.
//

// CoursesView.swift
import SwiftUI

struct CoursesView: View {
    @ObservedObject var dataClassifier = DataClassifier()
    @State private var searchText = ""
    let ScreenSize = UIScreen.main.bounds.size
    @Environment(\.dismiss) var dismiss
    var filteredCourses: [Course] {
        return dataClassifier.courses.filter {
            searchText.isEmpty || $0.id.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            if dataClassifier.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                List(filteredCourses, id: \.id) { course in
                    NavigationLink(destination: CourseDetailView(course: course)) {
                        Text(course.id)
                            .foregroundStyle(.primary)
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Courses")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel", role: .cancel){
                            dismiss()
                        }
                    }
                })
            }//test
        }
        .onAppear {
            dataClassifier.getData()
        }
    }
}

#Preview {
    CoursesView()
}
