//
//  FinTrackApp.swift
//  FinTrack
//
//  Created by Jacob Dunn on 2023-05-20.
//

import SwiftUI

@main
struct FinTrackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                ListView()
                    .tabItem {
                        Text("List")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                ExpenseEntryView()
                    .tabItem {
                        Text("Enter")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
