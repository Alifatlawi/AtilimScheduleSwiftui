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
                ProgressView()  // Display loading indicator while data is being loaded
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
            }
        }
        .onAppear {
            dataClassifier.getData()
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}


#Preview {
    CoursesView()
}
