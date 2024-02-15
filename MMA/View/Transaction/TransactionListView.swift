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
    
    @State private var selection: [Transact] = []

    var body: some View {
            List {
                ForEach(transactions) { transaction in
                    HStack(alignment: .top) {
                        
        
                        if transactionVM.multipleSelection {
                            Button {
                                handleSelection(multiSelect: transactionVM.multipleSelection, transaction: transaction)
                            } label: {
                                if selection.contains(transaction) {
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
                            
                            if let categoryName = transaction.category?.name {
                                Button(categoryName) {
                                    withAnimation {
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
                        if selection.contains(transaction) {
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
                    .background(selection.contains(transaction) ? Color.accentColor.opacity(0.33) : transactionVM.selectedTransaction == transaction ? Color.accentColor.opacity(0.33) : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
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
    
    private func handleSelection(multiSelect: Bool, transaction: Transact) {
        withAnimation {
            
            if multiSelect {
                if selection.contains(transaction) {
                    selection.removeAll(where: { $0.id == transaction.id })
                } else {
                    selection.append(transaction)
                }
                
                
            } else {
                if !selection.contains(transaction) {
                    selection = []
                    selection.append(transaction)
                } else {
                    selection = []
                }
            }
            transactionVM.selectedTransactions = selection
            print(transactionVM.selectedTransactions)
        }
    }
    
}

#Preview {
    TransactionListView(contentVM: ContentViewModel(),transactionVM: TransactionViewModel())
        .modelContainer(for: Transact.self, inMemory: true)
}
