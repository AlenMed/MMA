//
//  CategoryListView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    @Bindable var contentVM: ContentViewModel
    @Bindable var categoryVM: CategoryViewModel
    

    var body: some View {
        List {
            ForEach(categories) { category in
                CategoryCell(contentVM: contentVM, categoryVM: categoryVM, category: category)
            }
        }
        .navigationTitle("Categories")
        .onDisappear {
            categoryVM.selectedCategories = []
            categoryVM.selectedCategory = nil
            categoryVM.multipleSelection = false
        }
        .onAppear {
            withAnimation {
                categoryVM.multipleSelection = false
            }
        }
    }
}

#Preview {
    CategoryListView(contentVM: ContentViewModel(), categoryVM: CategoryViewModel())
}
