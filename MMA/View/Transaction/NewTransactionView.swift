//
//  NewTransactionView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct NewTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var categories: [Category]
    
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var amount: Double?
    @State private var category: Category?
    @State private var location: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button {
                    withAnimation {
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
            
            
            TextField("Title", text: $title)
            TextField("Note", text: $note)
            TextField("Amount", value: $amount, format: .number)
            
            HStack {
                Menu {
                    ForEach(categories) { item in
                        Button(item.name) {
                            category = item
                        }
                    }
                } label: {
                    Text(category?.name ?? "Category")
                }
                .frame(maxWidth: 180)
                Spacer()
                #if os(macOS)
                Button("Cancel") {
                    withAnimation {
                        dismiss()
                    }
                }
                #endif
                Button("Submit") {
                    addTransaction()
                }
                .foregroundStyle(Color.accentColor)
            }
        Spacer()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(12)

        //TODO: Add location
        
    }
    private func addTransaction() {
        let transaction = Transact(title: title, note: note, amount: amount ?? 0, timestamp: Date(), category: category, accountId: "No Account ID ")
        withAnimation {
            modelContext.insert(transaction)
        }
    }
}

#Preview {
    NewTransactionView()
}
