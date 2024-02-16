//
//  TransactionCell.swift
//  MMA
//
//  Created by ektamannen on 16/02/2024.
//

import SwiftUI

struct TransactionCell: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var contentVM: ContentViewModel
    @Bindable var transactionVM: TransactionViewModel
    @Bindable var categoryVM: CategoryViewModel
    
    let transaction: Transact
    
    var body: some View {
        HStack(alignment: .top) {
            
            if transactionVM.multipleSelection {
                Button {
                    handleSelection(multiSelect: transactionVM.multipleSelection, transaction: transaction)
                } label: {
                    if transactionVM.selectedTransactions.contains(transaction) {
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Image(systemName: "circle")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, -6)
                
                if let category = transaction.category {
                    Button(category.name) {
                        withAnimation {
                            categoryVM.selectedCategory = category
                            contentVM.showCategoryDetailSheet = true
                        }
                    }
                    .buttonStyle(CategoryButtonStyle())
                }
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
            if transactionVM.selectedTransactions.contains(transaction) {
                Button {
                    withAnimation {
                        transactionVM.selectedTransaction = transaction
                        contentVM.showTransactionDetailSheet = true
                    }
                } label: {
                    Image(systemName: "info.circle")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .onTapGesture {
            handleSelection(multiSelect: transactionVM.multipleSelection, transaction: transaction)
        }
        .padding(6)
        .background(transactionVM.selectedTransactions.contains(transaction) ? Color.accentColor.opacity(0.33) : transactionVM.selectedTransaction == transaction ? Color.accentColor.opacity(0.33) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    
    private func handleSelection(multiSelect: Bool, transaction: Transact) {
        withAnimation {

            if multiSelect {
                if transactionVM.selectedTransactions.contains(transaction) {
                    transactionVM.selectedTransactions.removeAll(where: { $0.id == transaction.id })
                } else {
                    transactionVM.selectedTransactions.append(transaction)
                }
                
                
            } else {
                if !transactionVM.selectedTransactions.contains(transaction) {
                    transactionVM.selectedTransactions = []
                    transactionVM.selectedTransactions.append(transaction)
                } else {
                    transactionVM.selectedTransactions = []
                }
            }
        }
    }
}

#Preview {
    TransactionCell(contentVM: ContentViewModel(), transactionVM: TransactionViewModel(), categoryVM: CategoryViewModel(), transaction: Transact(title: "Test", amount: 200, timestamp: Date(), accountId: "no id"))
}
