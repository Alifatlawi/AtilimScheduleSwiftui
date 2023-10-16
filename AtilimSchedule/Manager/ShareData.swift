//
//  ShareData.swift
//  AtilimSchedule
//
//  Created by Ali Amer on 10/16/23.
//

import Foundation

class SharedData: ObservableObject {
    static let shared = SharedData()
    
    @Published var facultyLink: String? {
        didSet {
            UserDefaults.standard.set(facultyLink, forKey: "FacultyLink")
        }
    }
    
    @Published var facultyName: String? {
        didSet {
            UserDefaults.standard.set(facultyName, forKey: "FacultyName")
        }
    }
    
    private init() {
        self.facultyLink = UserDefaults.standard.string(forKey: "FacultyLink")
        self.facultyName = UserDefaults.standard.string(forKey: "FacultyName")
    }
}
