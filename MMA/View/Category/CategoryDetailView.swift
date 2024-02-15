//
//  CategoryDetailView.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import SwiftUI
import SwiftData

struct CategoryDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var categoryVM: CategoryViewModel
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CategoryDetailView(categoryVM: CategoryViewModel())
}
