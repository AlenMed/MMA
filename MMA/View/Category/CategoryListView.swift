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
    
    @State private var selection: [Category] = []

    var body: some View {
        List {
            ForEach(categories) { category in
                HStack(alignment: .top) {
                    
                    if categoryVM.multipleSelection {
                        Button {
                            handleSelection(multiSelect: categoryVM.multipleSelection, category: category)
                        } label: {
                            if selection.contains(category) {
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
                }
                .padding(6)
                .background(selection.contains(category) ? Color.accentColor.opacity(0.33) : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .onTapGesture {
                    handleSelection(multiSelect: categoryVM.multipleSelection, category: category)
                }
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
    
    private func handleSelection(multiSelect: Bool, category: Category) {
        withAnimation {
            
            if multiSelect {
                if selection.contains(category) {
                    selection.removeAll(where: { $0.id == category.id })
                } else {
                    selection.append(category)
                }
                
                
            } else {
                if !selection.contains(category) {
                    selection = []
                    selection.append(category)
                } else {
                    selection = []
                }
            }
        }
    }
}

#Preview {
    CategoryListView(categoryVM: CategoryViewModel())
}
