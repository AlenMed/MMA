//
//  FinReportView.swift
//  MMA
//
//  Created by ektamannen on 18/02/2024.
//

import SwiftUI
import SwiftData

struct FinReportView: View {
    @Query private var transactions: [Transact]
    @Bindable var transactionVM: TransactionViewModel
    
    var totalExpenses: Double {
            transactions.filter { $0.amount < 0 }.reduce(0) { $0 + $1.amount }
        }
        
        var totalIncome: Double {
            transactions.filter { $0.amount > 0 }.reduce(0) { $0 + $1.amount }
        }
        
        var netBalance: Double {
            totalIncome + totalExpenses
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Income: \(totalIncome.formattedAsCurrency())")
                .fontWeight(.semibold)
            Text("Expenses: \(totalExpenses.formattedAsCurrency())")
                .fontWeight(.semibold)
            Text("Net: \(netBalance.formattedAsCurrency())")
                .fontWeight(.bold)
                .foregroundStyle(netBalance > 0 ? .green : .red)
        }
        .font(.title2)
        .padding(12)
    }
}

#Preview {
    FinReportView(transactionVM: TransactionViewModel())
}
