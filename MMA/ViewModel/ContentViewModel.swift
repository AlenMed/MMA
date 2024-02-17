//
//  ContentViewModel.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import Foundation

@Observable
class ContentViewModel {
    struct AppState {
        var id: Int
        var name: String
        var imageName: String
        
        init(id: Int, name: String, imageName: String) {
            self.id = id
            self.name = name
            self.imageName = imageName
        }
    }
    

    var appState: Int = 1
    
    var showNewTransactionSheet: Bool = false
    var showTransactionDetailSheet: Bool = false
    var showNewCategorySheet: Bool = false
    var showCategoryDetailSheet: Bool = false
    
    let appStates: [AppState] = [
        AppState(id: 1, name: "Home", imageName: "house.fill"),
        AppState(id: 2, name: "Charts", imageName: "chart.bar.fill"),
        AppState(id: 3, name: "Transactions", imageName: "creditcard.fill"),
        AppState(id: 4, name: "Categories", imageName: "square.filled.on.square")
    ]
    
    let transactionMenuOptions: [Toolbar.ToolbarMenuOption] = [
        Toolbar.ToolbarMenuOption(
                id: 1,
                name: "Change",
                icon: "square.and.pencil",
                subOptions: [
                    Toolbar.ToolbarMenuOption.SubOption(name: "Category"),
                    Toolbar.ToolbarMenuOption.SubOption(name: "Account")
                            ]
                ),
    
        Toolbar.ToolbarMenuOption(
                id: 2,
                name: "Select",
                icon: "checklist"),
    
        Toolbar.ToolbarMenuOption(
                id: 3,
                name: "Delete",
                icon: "trash.fill",
                color: .red)
    ]
    
    let categoryMenuOptions: [Toolbar.ToolbarMenuOption] = [
        Toolbar.ToolbarMenuOption(
                id: 1,
                name: "Change",
                icon: "square.and.pencil",
                subOptions: [
                    Toolbar.ToolbarMenuOption.SubOption(name: "TBA"),
                    Toolbar.ToolbarMenuOption.SubOption(name: "TBA"),
                            ]
                ),
        
        Toolbar.ToolbarMenuOption(
                id: 2,
                name: "Select",
                icon: "checklist"),
    
        Toolbar.ToolbarMenuOption(
                id: 3,
                name: "Delete",
                icon: "trash.fill",
                color: .red)
    ]

}
