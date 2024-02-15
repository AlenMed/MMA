//
//  Toolbar.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import SwiftUI

#if os(iOS)
struct Toolbar: ToolbarContent {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var contentVM: ContentViewModel
    @Bindable var transactionVM: TransactionViewModel
    @Bindable var categoryVM: CategoryViewModel
    
    
    var body: some ToolbarContent {
        ToolbarItem {
            
            //MARK: Decide actions based on tab
            Button {
                withAnimation {
                    switch contentVM.appState {
                    case 1, 2, 3:
                        contentVM.showNewTransactionSheet = true
                    case 4:
                        contentVM.showNewCategorySheet = true
                    default:
                        contentVM.showNewTransactionSheet = true
                    }
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(Color.accentColor)
                    .fontWeight(.bold)
            }
        }
        
        if (contentVM.appState == 3 || contentVM.appState == 4),
           (transactionVM.selectedTransaction != nil || categoryVM.selectedCategory != nil) {
            ToolbarItem {
                Button {
                    withAnimation {
                        deleteItem()
                    }
                } label: {
                    Image(systemName: "minus")
                        .foregroundStyle(Color.accentColor)
                        .fontWeight(.bold)
                }
            }
        }
    }
    private func deleteItem() {
        if let _ = transactionVM.selectedTransaction, let _ = categoryVM.selectedCategory {
                print("Error: Two items selected.")
                return
            }
        
        if let transaction = transactionVM.selectedTransaction {
            modelContext.delete(transaction)
        }
        if let category = categoryVM.selectedCategory {
            modelContext.delete(category)
        }
    }
}
#endif



#if os(macOS)
struct Toolbar: ToolbarContent {
    @Bindable var contentVM: ContentViewModel
    @Bindable var transactionVM: TransactionViewModel
    @Bindable var categoryVM: CategoryViewModel
    
    var body: some ToolbarContent {
        
        ToolbarItem {
                Menu {
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        
        
        
        ToolbarItem {
            Button {
                withAnimation {
                    switch contentVM.appState {
                    case 1, 2, 3:
                        contentVM.showNewTransactionSheet = true
                    case 4:
                        contentVM.showNewCategorySheet = true
                    default:
                        contentVM.showNewTransactionSheet = true
                    }
                }
            } label: {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}
#endif

