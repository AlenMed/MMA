//
//  ContentViewModel.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import Foundation

@Observable
class ContentViewModel {
    
//MARK: Navigating on macOS
    let appStates: [AppState] = [
        AppState(id: 1, name: "Home", imageName: "house.fill"),
        AppState(id: 1, name: "Transactions", imageName: "creditcard.fill"),
        AppState(id: 1, name: "Charts", imageName: "chart.bar.fill"),
        AppState(id: 1, name: "Categories", imageName: "square.filled.on.square")
    ]
    
    var appState: Int = 1

}
