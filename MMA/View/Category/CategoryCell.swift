//
//  CategoryCell.swift
//  MMA
//
//  Created by ektamannen on 16/02/2024.
//

import SwiftUI

struct CategoryCell: View {
    @Bindable var contentVM: ContentViewModel
    @Bindable var categoryVM: CategoryViewModel
    
    let category: Category
    
    
    var body: some View {
        HStack(alignment: .top) {
            
            if categoryVM.multipleSelection {
                Button {
                    categoryVM.handleCellSelection(multiSelect: categoryVM.multipleSelection, category: category)
                } label: {
                    if categoryVM.selectedCategories.contains(category) {
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Image(systemName: "circle")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Text("\(category.name)")
                
            Spacer()
            
            Text(DateFormatter.localizedString(from: category.timestamp, dateStyle: .medium, timeStyle: .short))
            
            if categoryVM.selectedCategories.contains(category) {
                Button {
                    withAnimation {
                        categoryVM.selectedCategory = category
                        contentVM.showCategoryDetailSheet = true
                    }
                } label: {
                    Image(systemName: "info.circle")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(6)
        .background(categoryVM.selectedCategories.contains(category) ? Color.accentColor.opacity(0.33) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .onTapGesture {
            categoryVM.handleCellSelection(multiSelect: categoryVM.multipleSelection, category: category)
        }
        .onLongPressGesture(minimumDuration: 0.2) {
            withAnimation {
                categoryVM.selectedCategory = category
                contentVM.showCategoryDetailSheet = true
            }
        }
    }
}

#Preview {
    CategoryCell(contentVM: ContentViewModel(), categoryVM: CategoryViewModel(), category: Category(name: "Preview", timestamp: Date(), transactions: []))
}
