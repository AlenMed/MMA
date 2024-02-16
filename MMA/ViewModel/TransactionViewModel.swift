//
//  TransactionViewModel.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import Foundation
import SwiftUI

@Observable
class TransactionViewModel {
    var selectedTransaction: Transact?
    var selectedTransactions: [Transact] = []
    
    var multipleSelection: Bool = false
    
    init(selectedTransaction: Transact? = nil, selectedTransactions: [Transact] = [], multipleSelection: Bool = false) {
        self.selectedTransaction = selectedTransaction
        self.selectedTransactions = selectedTransactions
        self.multipleSelection = multipleSelection
    }
    
    func toggleMultipleSelection() {
        withAnimation {
            multipleSelection.toggle()
            selectedTransactions = []
        }
    }
    
    func handleCellSelection(multiSelect: Bool, transaction: Transact) {
        withAnimation {
            
            if selectedTransactions.contains(transaction) {
                selectedTransaction = nil
            } else {
                selectedTransaction = transaction
            }
            
            if multiSelect {
                if selectedTransactions.contains(transaction) {
                    selectedTransactions.removeAll(where: { $0.id == transaction.id })
                } else {
                    selectedTransactions.append(transaction)
                }
                
                
            } else {
                if !selectedTransactions.contains(transaction) {
                    selectedTransactions = []
                    selectedTransactions.append(transaction)
                } else {
                    selectedTransactions = []
                }
            }
        }
    }
}
