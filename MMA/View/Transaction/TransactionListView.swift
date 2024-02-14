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
    
    @State private var selectedTransaction: Transact?

    var body: some View {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text(transaction.category?.name ?? "")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(transaction.amount.formattedAsCurrency())
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("\(transaction.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                                .fontWeight(.ultraLight)
                                .font(.system(size: 8))
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedTransaction = transaction
                        }
                    }
                    .padding(6)
                    .background(selectedTransaction == transaction ? Color.accentColor.opacity(0.33) : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Transactions")
            .onDisappear {
                selectedTransaction = nil
            }
    }

    private func addItem() {
        withAnimation {
            let transaction = Transact(id: UUID(), title: "Test", amount: 200, timestamp: Date(), accountId: "richmanaccount")
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
