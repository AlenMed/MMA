//
//  MMAApp.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI
import SwiftData

@main
struct MMAApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Transact.self,
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
            #if os(iOS)
            iOSContentView()
            #endif
            #if os(macOS)
            MacOSContentView()
            #endif
        }
        .modelContainer(sharedModelContainer)
    }
}
