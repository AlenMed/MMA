//
//  CategoryViewModel.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import Foundation

@Observable
class CategoryViewModel {
    var selectedCategory: Category?
    
    init(selectedCategory: Category? = nil) {
        self.selectedCategory = selectedCategory
    }
}
