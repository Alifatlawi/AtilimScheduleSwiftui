import SwiftUI

struct AddExamView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var courseName: String = ""
    @State private var examDate: Date = Date()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Course Information")) {
                    TextField("Course Name", text: $courseName)
                }
                
                Section(header: Text("Exam Date and Time")) {
                    DatePicker("Select Exam Date and Time", selection: $examDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
            }
            .navigationTitle("Add Exam")
            .toolbar(content: {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add"){
                        addExam()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel){
                        dismiss()
                    }
                }
            })
        }
    }
    
    private func addExam() {
        let newExam = Exam(context: viewContext)
        newExam.courseName = courseName
        newExam.examDate = examDate
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}



#Preview(body: {
    AddExamView()
})
