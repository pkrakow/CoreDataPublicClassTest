//
//  CoreDataPublicClassTestApp.swift
//  CoreDataPublicClassTest
//
//  Created by Paul Krakow on 1/25/21.
//

import SwiftUI
import CoreData

@main
struct CoreDataPublicClassTestApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
