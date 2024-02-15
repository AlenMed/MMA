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

    var body: some View {
            List {
                ForEach(transactions) { transaction in
                    HStack(alignment: .top) {
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
                    //TODO: FIX
                        if transaction == transactionVM.selectedTransaction {
                            Button {
                                withAnimation {
                                    contentVM.showTransactionDetailSheet = true
                                }
                            } label: {
                                Image(systemName: "info.circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            transactionVM.selectedTransaction = transaction
                        }
                    }
                    .padding(6)
                    .background(transactionVM.selectedTransaction == transaction ? Color.accentColor.opacity(0.33) : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            .navigationTitle("Transactions")
            .onDisappear {
                transactionVM.selectedTransaction = nil
            }
    }
}

#Preview {
    TransactionListView(contentVM: ContentViewModel(),transactionVM: TransactionViewModel())
        .modelContainer(for: Transact.self, inMemory: true)
}
