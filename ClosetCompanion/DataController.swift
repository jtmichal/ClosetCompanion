//
//  DataController.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 6/27/24.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "ClosetCompanion")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
