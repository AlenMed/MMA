//
//  TransactionViewModel.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import Foundation

@Observable
class TransactionViewModel {
    var selectedTransaction: Transact?
    
    init(selectedTransaction: Transact? = nil) {
        self.selectedTransaction = selectedTransaction
    }
}
