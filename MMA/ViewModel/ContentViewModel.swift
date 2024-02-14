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
    
//MARK: Navigating on macOS
    let appStates: [AppState] = [
        AppState(id: 1, name: "Home", imageName: "house.fill"),
        AppState(id: 2, name: "Charts", imageName: "chart.bar.fill"),
        AppState(id: 3, name: "Transactions", imageName: "creditcard.fill"),
        AppState(id: 4, name: "Categories", imageName: "square.filled.on.square")
    ]
    
    var appState: Int = 1

}
