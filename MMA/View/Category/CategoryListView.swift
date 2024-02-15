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
    
    @Bindable var categoryVM: CategoryViewModel

    var body: some View {
        List {
            ForEach(categories) { category in
                
                HStack {
                    Text("\(category.name)")
                        
                    Spacer()
                    
                    Text(DateFormatter.localizedString(from: category.timestamp, dateStyle: .medium, timeStyle: .short))
                }
                .padding(6)
                .background(categoryVM.selectedCategory == category ? Color.accentColor.opacity(0.33) : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .onTapGesture {
                    withAnimation {
                        categoryVM.selectedCategory = category
                    }
                }
            }
        }
        .navigationTitle("Categories")
        .onDisappear {
            categoryVM.selectedCategory = nil
        }
    }
}

#Preview {
    CategoryListView(categoryVM: CategoryViewModel())
}
