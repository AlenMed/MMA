//
//  Category.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique)
    var name: String
    var timestamp: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Transact.category)
    var transactions: [Transact?]
    
    init(name: String, timestamp: Date, transactions: [Transact?]) {
        self.name = name
        self.timestamp = timestamp
        self.transactions = transactions
    }
}
