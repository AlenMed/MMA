//
//  Item.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import Foundation
import SwiftData

@Model
final class Transact {
    var id: UUID
    var title: String
    var note: String?
    var amount: Double
    var timestamp: Date
    var category: Category?
    var accountId: String
    var location: String?
    
    init(id: UUID = UUID(), title: String, note: String? = nil, amount: Double, timestamp: Date, category: Category? = nil, accountId: String, location: String? = nil) {
        self.id = id
        self.title = title
        self.note = note
        self.amount = amount
        self.timestamp = timestamp
        self.category = category
        self.accountId = accountId
        self.location = location
    }
    
}
