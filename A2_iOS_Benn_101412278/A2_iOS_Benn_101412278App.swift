//
//  A2_iOS_Benn_101412278App.swift
//  A2_iOS_Benn_101412278
//
//  Created by Benn Graham on 2026-03-29.
//

import SwiftUI
import CoreData

@main
struct A2_iOS_Benn_101412278App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
