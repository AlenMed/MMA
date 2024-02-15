//
//  MacOSContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

#if os(macOS)
struct MacOSContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var contentVM: ContentViewModel
    @State var transactionVM: TransactionViewModel
    @State var categoryVM: CategoryViewModel
    
    var body: some View {
        NavigationSplitView(sidebar: {
            MacOSSidebar(contentVM: contentVM)
        }) {
            viewForAppState()
        }
        .sheet(isPresented: $contentVM.showNewCategorySheet) {
            NewCategoryView()
        }
        .sheet(isPresented: $contentVM.showCategoryDetailSheet) {
            CategoryDetailView(categoryVM: categoryVM)
        }
        .sheet(isPresented: $contentVM.showNewTransactionSheet) {
            NewTransactionView()
        }
        .sheet(isPresented: $contentVM.showTransactionDetailSheet) {
            TransactionDetailView(transactionVM: transactionVM)
        }
        
        .toolbar {
            Toolbar(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
        }
    }
    
    @ViewBuilder
    private func viewForAppState() -> some View {
        switch contentVM.appState {
        case 1:
            HomeView()
        case 2:
            ChartView()
        case 3:
            TransactionListView(contentVM: contentVM, transactionVM: transactionVM)
        case 4:
            CategoryListView(categoryVM: categoryVM)
        default:
            Text("Unrecognised View")
        }
    }
}

#Preview {
    MacOSContentView(contentVM: ContentViewModel(), transactionVM: TransactionViewModel(), categoryVM: CategoryViewModel())
}
#endif
