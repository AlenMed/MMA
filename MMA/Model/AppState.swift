//
//  AppState.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import Foundation

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
