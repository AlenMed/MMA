//
//  NewCategoryView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct NewCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var categories: [Category]
    
    @State private var name: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
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
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack() {
                Spacer()
                #if os(macOS)
                Button("Cancel") {
                    withAnimation {
                        dismiss()
                    }
                }
                #endif
                Button("Submit") {
                    addCategory()
                }
                .foregroundStyle(Color.accentColor)
            }
        }
        .padding(12)
    }
    
    private func addCategory() {
        let category = Category(name: name, timestamp: Date(), transactions: [])
        withAnimation {
            modelContext.insert(category)
        }
    }
}

#Preview {
    NewCategoryView()
}
