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
    
    @State var contentVM: ContentViewModel
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
                .frame(minWidth: 320, maxWidth: 600, minHeight: 420, maxHeight: 720)
        }
        .sheet(isPresented: $contentVM.showNewTransactionSheet) {
            NewTransactionView()
        }
        .sheet(isPresented: $contentVM.showTransactionDetailSheet) {
            TransactionDetailView(transactionVM: transactionVM)
                .frame(minWidth: 320, maxWidth: 600, minHeight: 420, maxHeight: 420)
        }
        .toolbar {
            Toolbar(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
        }
    }
    
    @ViewBuilder
    private func viewForAppState() -> some View {
        switch contentVM.appState {
        case 1:
            HomeView(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
        case 2:
            ChartView()
        case 3:
            TransactionListView(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
        case 4:
            CategoryListView(contentVM: contentVM, categoryVM: categoryVM)
        default:
            Text("Unrecognised View")
        }
    }
}

#Preview {
    MacOSContentView(contentVM: ContentViewModel(), transactionVM: TransactionViewModel(), categoryVM: CategoryViewModel())
}
#endif
