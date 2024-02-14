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
            Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State var contentVM = ContentViewModel()

    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            iOSContentView(contentVM: contentVM)
            #endif
            #if os(macOS)
            MacOSContentView(contentVM: contentVM)
            #endif
        }
        .modelContainer(sharedModelContainer)
    }
}
