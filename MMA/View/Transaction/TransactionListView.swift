//
//  ContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [Transact]

    var body: some View {
            List {
                ForEach(transactions) { transaction in
                    NavigationLink {
                        Text("Item at \(transaction.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(transaction.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
    }

    private func addItem() {
        withAnimation {
            let transaction = Transact(timestamp: Date())
            modelContext.insert(transaction)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(transactions[index])
            }
        }
    }
}

#Preview {
    TransactionListView()
        .modelContainer(for: Transact.self, inMemory: true)
}
