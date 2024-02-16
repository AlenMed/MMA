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
    
    @Bindable var contentVM: ContentViewModel
    @Bindable var transactionVM: TransactionViewModel
    @Bindable var categoryVM: CategoryViewModel

    var body: some View {
        List {
            ForEach(transactions) { transaction in
                TransactionCell(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM, transaction: transaction)
            }
        }
        .navigationTitle("Transactions")
        .onDisappear {
            transactionVM.selectedTransactions = []
            transactionVM.multipleSelection = false
            transactionVM.selectedTransaction = nil
        }
        .onAppear {
            withAnimation {
                transactionVM.multipleSelection = false
            }
        }
    }
}

#Preview {
    TransactionListView(contentVM: ContentViewModel(),transactionVM: TransactionViewModel(), categoryVM: CategoryViewModel())
        .modelContainer(for: Transact.self, inMemory: true)
}
