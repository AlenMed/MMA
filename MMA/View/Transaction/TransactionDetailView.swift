//
//  TransactionDetailView.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import SwiftUI
import SwiftData

struct TransactionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var categories: [Category]
    
    @State var transactionVM: TransactionViewModel
    
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var amount: Double = 0
    @State private var category: Category?
    @State private var timestamp: Date?
    @State private var accountId: String = ""
    @State private var location: String = ""
    @State private var id: UUID?

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Button {
                    withAnimation {
                        transactionVM.selectedTransaction = nil
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            
            
            
            VStack(alignment: .leading, spacing: 24) {
                TextField("Title", text: $title)
                TextField("Note", text: $note)
                TextField("Amount", value: $amount, format: .number)
                
                Menu {
                    ForEach(categories, id: \.id) { item in
                        Button(item.name) {
                            category = item
                        }
                    }
                } label: {
                    Text(transactionVM.selectedTransaction?.category?.name ?? "Change Category")
                }
                
                HStack {
                    Text("\(timestamp ?? Date(), format: Date.FormatStyle(date: .numeric, time: .standard))")
                        .fontWeight(.light)
                    
                Spacer()
                    
                    Text(location)
                }
                
                Button("Submit") {
                   submitChanges()
                }
                
                
            }
            VStack {
                Spacer()
                HStack {
                    Text("Transaction ID: \(id?.uuidString ?? "no ID")")
                        .font(.system(size: 6, weight: .ultraLight))
                Spacer()
                    Button {
                        withAnimation {
                            dismiss()
                            if let transaction = transactionVM.selectedTransaction {
                                modelContext.delete(transaction)
                                transactionVM.selectedTransaction = nil
                            }
                        }
                } label: {
                    Image(systemName: "trash.fill")
                        .foregroundStyle(.red)
                }
                }
            }
        }
        .padding(12)
        .onAppear {
            if let transaction = transactionVM.selectedTransaction {
                title = transaction.title
                note = transaction.note ?? "No note"
                amount = transaction.amount
                category = transaction.category
                timestamp = transaction.timestamp
                accountId = transaction.accountId
                location = transaction.location ?? "No location"
                id = transaction.id
            }
        }
    }
    
    private func submitChanges() {
        if let transaction = transactionVM.selectedTransaction {
            withAnimation {
                transaction.title = title
                transaction.note = note
                transaction.amount = amount
                transaction.category = category
                transaction.timestamp = timestamp ?? Date()
                transaction.accountId = accountId
                transaction.location = location
                try? modelContext.save()
            }
        }
    }
}

#Preview {
    TransactionDetailView(transactionVM: TransactionViewModel())
}
