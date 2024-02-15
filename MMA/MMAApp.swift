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
    @State var transactionVM = TransactionViewModel()
    @State var categoryVM = CategoryViewModel()

    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            iOSContentView(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
            #endif
            #if os(macOS)
            MacOSContentView(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
            #endif
        }
        .modelContainer(sharedModelContainer)
    }
}
