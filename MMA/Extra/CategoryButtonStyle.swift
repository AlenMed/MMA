//
//  CategoryButtonStyle.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import SwiftUI

struct CategoryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption2)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}


