//
//  CurrencyFormatter.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import Foundation

extension Double {
    func formattedAsCurrency() -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            if let formattedString = formatter.string(from: NSNumber(value: self)) {
                return formattedString
            } else {
                return "\(self)"
            }
        }
}
