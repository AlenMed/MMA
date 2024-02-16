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
    
    func handleCellSelection(multiSelect: Bool, category: Category) {
        withAnimation {
            if selectedCategories.contains(category) {
                selectedCategory = nil
            } else {
                selectedCategory = category
            }
            
            if multiSelect {
                if selectedCategories.contains(category) {
                    selectedCategories.removeAll(where: { $0.id == category.id })
                } else {
                    selectedCategories.append(category)
                }
                
                
            } else {
                if !selectedCategories.contains(category) {
                    selectedCategories = []
                    selectedCategories.append(category)
                } else {
                    selectedCategories = []
                }
            }
        }
    }
}
