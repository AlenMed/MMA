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

    var body: some View {
        List {
            ForEach(categories) { category in
                
                Text("\(category.name)")
            }
        }
        .navigationTitle("Categories")
    }
}

#Preview {
    CategoryListView()
}
