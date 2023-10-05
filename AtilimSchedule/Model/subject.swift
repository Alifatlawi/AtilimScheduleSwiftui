import Foundation

struct Course {
    var id: String  // e.g., "CMPE251"
    var name: String  // e.g., "Discrete Computational Structures"
    var sections: [Section]
}

struct Section {
    var id: String  // e.g., "01", "02", "03", etc.
    var teacher: Teacher
    var schedules: [Schedule]
}

struct Teacher {
    var name: String  // e.g., "Güzin Türkmen", "Erhan Gokcay"
}

struct Schedule {
    var day: String  // e.g., "Salı", "Pazartesi"
    var classroom: String  // e.g., "2017H", "2015H"
    var period: String  // e.g., "4.", "5."
    var startTime: String  // e.g., "12:30", "13:30"
    var endTime: String  // e.g., "13:20", "14:20"
    var duration: String  // e.g., "2 period(s)", "1 period(s)"
}
