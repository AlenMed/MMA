//
//  CategoryDetailView.swift
//  MMA
//
//  Created by ektamannen on 15/02/2024.
//

import SwiftUI
import SwiftData

struct CategoryDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var categoryVM: CategoryViewModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Button {
                    withAnimation {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
            Spacer()
            }
            
            
            if let category = categoryVM.selectedCategory {
                VStack {
                    Text("\(category.name)")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    if let transact = category.transactions {
                        List(transact) { transaction in
                            HStack {
                                Text(transaction.title)
                                Spacer()
                                Text(transaction.amount.formattedAsCurrency())
                            }
                        }
                        .padding(12)
                        #if os(macOS)
                        .listStyle(.inset(alternatesRowBackgrounds: true))
                        #endif
                        }
                        
                    
                }
            } else {
                Text("Error: Unrecognised category.")
            }
        }
        .padding(12)
    }
}

#Preview {
    CategoryDetailView(categoryVM: CategoryViewModel())
}
