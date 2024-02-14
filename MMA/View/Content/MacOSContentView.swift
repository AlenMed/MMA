//
//  MacOSContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

#if os(macOS)
struct MacOSContentView: View {
    @Bindable var contentVM: ContentViewModel
    
    var body: some View {
        NavigationSplitView(sidebar: {
            MacOSSidebar(contentVM: contentVM)
        }) {
            viewForAppState()
        }
        .sheet(isPresented: $contentVM.showNewCategorySheet) {
            NewCategoryView()
        }
        .sheet(isPresented: $contentVM.showNewTransactionSheet) {
            NewTransactionView()
        }
        .toolbar {
            ToolbarItem {
//MARK: Determine action depending on state
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
                        .fontWeight(.bold)
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
    }
    
    
//MARK: See contentVM
    @ViewBuilder
    private func viewForAppState() -> some View {
        switch contentVM.appState {
        case 1:
            HomeView()
        case 2:
            ChartView()
        case 3:
            TransactionListView()
        case 4:
            CategoryListView()
        default:
            Text("Unrecognised View")
        }
    }
}

#Preview {
    MacOSContentView(contentVM: ContentViewModel())
}
#endif
