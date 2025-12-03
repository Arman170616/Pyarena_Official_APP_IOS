//
//  SchoolApp.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

@main
struct SchoolApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            School.self,
            Teacher.self,
            NewsArticle.self,
            Program.self,
            Activity.self,
            Career.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CorporateHomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
