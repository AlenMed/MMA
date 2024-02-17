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
           (transactionVM.selectedTransactions != [] || categoryVM.selectedCategories != []) {
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
//TODO: Replace
    private func deleteItem() {
        if let _ = transactionVM.selectedTransaction, let _ = categoryVM.selectedCategory {
            print("Two items selected")
            return
        }
        
        if transactionVM.selectedTransactions != [] {
            for transaction in transactionVM.selectedTransactions {
                modelContext.delete(transaction)
                
            }
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

struct Toolbar: ToolbarContent {
    @Environment(\.modelContext) private var modelContext
    @Bindable var contentVM: ContentViewModel
    @Bindable var transactionVM: TransactionViewModel
    @Bindable var categoryVM: CategoryViewModel
    
    struct ToolbarMenuOption {
        var id: Int
        var name: String
        var icon: String
        var color: Color?
        var subOptions: [SubOption]?
        
        init(id: Int, name: String, icon: String, color: Color? = nil, subOptions: [SubOption]? = nil) {
            self.id = id
            self.name = name
            self.icon = icon
            self.color = color
            self.subOptions = subOptions
        }
        
        struct SubOption {
            var id: UUID
            var name: String
            
            init(id: UUID = UUID(), name: String) {
                self.id = id
                self.name = name
            }
        }
    }
    
    func handleOption(option: ToolbarMenuOption) {
        if option.name == "Select" && contentVM.appState == 3 {
            transactionVM.toggleMultipleSelection()
        }
        
        if option.name == "Delete" && contentVM.appState == 3 {
            for transaction in transactionVM.selectedTransactions {
                modelContext.delete(transaction)
            }
            transactionVM.selectedTransactions = []
            
            if let transaction = transactionVM.selectedTransaction {
                modelContext.delete(transaction)
            }
        }
        
        
        
        if option.name == "Select" && contentVM.appState == 4 {
            categoryVM.toggleMultipleSelection()
        }
        
        if option.name == "Delete" && contentVM.appState == 4 {
            for category in categoryVM.selectedCategories {
                modelContext.delete(category)
            }
            categoryVM.selectedCategories = []
            if let category = categoryVM.selectedCategory {
                modelContext.delete(category)
            }
        }
    }
    
    func handleSubOption(subOption: ToolbarMenuOption.SubOption) {
        
    }
    
    
    
    var body: some ToolbarContent {
        ToolbarItem {
            switch contentVM.appState {
            case 1:
                Text("Menu")
            case 2:
                Text("Yo")
            case 3:
                Menu {
                    ForEach(contentVM.transactionMenuOptions, id: \.id) { option in
                        
                        if let subOptions = option.subOptions {
                            Menu {
                                ForEach(subOptions, id: \.id) { subOption in
                                    Button(subOption.name) {
                                        handleSubOption(subOption: subOption)
                                    }
                                }
                            } label: {
                                Text(option.name)
                            }
                        } else {
                            Button {
                                handleOption(option: option)
                            } label: {
                                Image(systemName: option.icon)
                                Text(option.name)
                            }
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            case 4:
                Menu {
                    ForEach(contentVM.categoryMenuOptions, id: \.id) { option in
                        
                        if let subOptions = option.subOptions {
                            Menu {
                                ForEach(subOptions, id: \.id) { subOption in
                                    Button(subOption.name) {
                                        handleSubOption(subOption: subOption)
                                    }
                                }
                            } label: {
                                Text(option.name)
                            }
                        } else {
                            Button {
                                handleOption(option: option)
                            } label: {
                                Image(systemName: option.icon)
                                Text(option.name)
                            }
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            default:
                Text("")
            }
        }
        
        ToolbarItem {
            Button {
                switch contentVM.appState {
                case 1, 2, 3:
                    contentVM.showNewTransactionSheet = true
                case 4:
                    contentVM.showNewCategorySheet = true
                default:
                    contentVM.showNewTransactionSheet = true
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

