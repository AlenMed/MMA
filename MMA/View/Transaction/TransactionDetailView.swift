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
    
    @State var transactionVM: TransactionViewModel
    
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
            if let transaction = transactionVM.selectedTransaction {
                Text(transaction.title)
                Text(transaction.note ?? "No note")
                Text(transaction.amount.formattedAsCurrency())
                Text("\(transaction.timestamp)")
                Text(transaction.accountId)
                Text(transaction.category?.name ?? "No category")
                Text(transaction.location ?? "No location")
                
                Text("Transaction id: \(transaction.id)")
                    .fontWeight(.ultraLight)
                
                Button {
                    withAnimation {
                        dismiss()
                        modelContext.delete(transaction)
                    }
                } label: {
                    Image(systemName: "trash.fill")
                }
            }
        }
        .padding(12)
    }
}

#Preview {
    TransactionDetailView(transactionVM: TransactionViewModel())
}
