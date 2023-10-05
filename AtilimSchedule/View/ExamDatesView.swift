//
//  ExamDatesView.swift
//  CourseFinder
//
//  Created by Tacettin Pekin on 1.10.2023.
//


import SwiftUI
import CoreData

struct ExamDatesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Exam.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Exam.examDate, ascending: true)],
        predicate: NSPredicate(format: "examDate >= %@", Date() as NSDate)
    ) private var exams: FetchedResults<Exam>
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(exams, id: \.self) { exam in
                    VStack(alignment: .leading) {
                        Text(exam.courseName ?? "Unknown Course")
                            .font(.headline)
                        Text(dateFormatter.string(from: exam.examDate ?? Date()))
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Exam Dates")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel){
                        dismiss()
                    }
                }
            })
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let exam = exams[index]
            viewContext.delete(exam)
        }

        do {
            try viewContext.save()
        } catch {
            // Handle the Core Data error
            print(error.localizedDescription)
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()



#Preview {
    ExamDatesView()
}
