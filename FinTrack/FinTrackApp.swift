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
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                ExpenseEntryView()
                    .tabItem {
                        Text("Enter")
                        Image(systemName: "doc.fill.badge.plus")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                SettingsView()
                    .tabItem {
                       Text("Settings")
                        Image(systemName: "gearshape.fill")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                SubcategoryView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
