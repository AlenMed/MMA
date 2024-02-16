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
            transactionVM.selectedTransaction = nil
        }
        if let category = categoryVM.selectedCategory {
            modelContext.delete(category)
            categoryVM.selectedCategory = nil
        }
    }
}
#endif



#if os(macOS)

struct ToolbarMenuOption {
    var id: Int
    var name: String
    var icon: String
    var color: Color?
    
    init(id: Int, name: String, icon: String, color: Color? = nil) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
    }
}

struct Toolbar: ToolbarContent {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var contentVM: ContentViewModel
    @Bindable var transactionVM: TransactionViewModel
    @Bindable var categoryVM: CategoryViewModel
    
    
    let menuOptions: [ToolbarMenuOption] = [
        ToolbarMenuOption(id: 1, name: "Select", icon: "checklist"),
        ToolbarMenuOption(id: 2, name: "Delete", icon: "trash.fill", color: Color.red)
    ]
    
    func handleCommand(command: ToolbarMenuOption) {
        
            if command.name == "Select" && contentVM.appState == 3 {
                transactionVM.toggleMultipleSelection()
            }
            
            if command.name == "Delete" && contentVM.appState == 3 {
                for transaction in transactionVM.selectedTransactions {
                        modelContext.delete(transaction)
                }
                transactionVM.selectedTransactions = []
                
                if let transaction = transactionVM.selectedTransaction {
                    modelContext.delete(transaction)
                }
            }
            
            
            
            if command.name == "Select" && contentVM.appState == 4 {
                categoryVM.toggleMultipleSelection()
            }
            
            if command.name == "Delete" && contentVM.appState == 4 {
                for category in categoryVM.selectedCategories {
                    modelContext.delete(category)
                }
                categoryVM.selectedCategories = []
                if let category = categoryVM.selectedCategory {
                    modelContext.delete(category)
                }
            }
        
        
    }
    
    
    var body: some ToolbarContent {
        
        ToolbarItem {
                Menu {
                    ForEach(menuOptions, id: \.id) { option in
                        Button {
                            handleCommand(command: option)
                        } label: {
                            HStack {
                                Text(option.name)
                                Spacer()
                                Image(systemName: option.icon)
                                    .foregroundStyle(option.color ?? Color.primary, .primary)
                            }
                        }
                    }
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

