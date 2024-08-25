//
//  ClosetCompanionApp.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/18/23.
//

import SwiftUI

@main
struct ClosetCompanionApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
