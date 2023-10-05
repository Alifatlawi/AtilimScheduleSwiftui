//
//  DatabaseController.swift
//  AtilimSchedule
//
//  Created by Tacettin Pekin on 6.10.2023.
//

import Foundation
import CoreData
import SwiftUI

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "Database")
    
    init() {
        container.loadPersistentStores { descriptoin, error in
            if let error = error {
                print("Core Data failed to load : \(error.localizedDescription)")
            }
        }
    }
}


extension Color {
    var hex: String? {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return "#0000FF" // Default to blue if cgColor is nil or not enough components
        }
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
