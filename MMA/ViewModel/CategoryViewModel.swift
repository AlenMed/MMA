//
//  CategoryViewModel.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import Foundation
import SwiftUI

@Observable
class CategoryViewModel {
    var selectedCategory: Category?
    var selectedCategories: [Category] = []
    
    var multipleSelection: Bool = false
    
    init(selectedCategory: Category? = nil, selectedCategories: [Category] = [], multipleSelection: Bool = false) {
        self.selectedCategory = selectedCategory
        self.selectedCategories = selectedCategories
        self.multipleSelection = multipleSelection
    }
    
    func toggleMultipleSelection() {
        withAnimation {
            multipleSelection.toggle()
            selectedCategories = []
        }
    }
}
