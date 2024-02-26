//
//  iOSContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

#if os(iOS)
struct iOSContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var contentVM: ContentViewModel
    @Bindable var transactionVM: TransactionViewModel
    @Bindable var categoryVM: CategoryViewModel
    
    @State private var tabSelection: Int = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tabSelection) {
                HomeView(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(1)
                
                ChartView()
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                    }
                    .tag(2)
                
                TransactionListView(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
                    .tabItem {
                        Image(systemName: "creditcard.fill")
                    }
                    .tag(3)
                
                CategoryListView(contentVM: contentVM, categoryVM: categoryVM)
                    .tabItem {
                        Image(systemName: "square.filled.on.square")
                    }
                    .tag(4)
            }
            .sheet(isPresented: $contentVM.showNewTransactionSheet) {
                NewTransactionView()
            }
            .sheet(isPresented: $contentVM.showTransactionDetailSheet, onDismiss: {
                withAnimation {
                    transactionVM.selectedTransaction = nil
                }
            }) {
                TransactionDetailView(transactionVM: transactionVM)
            }
            .sheet(isPresented: $contentVM.showNewCategorySheet) {
                NewCategoryView()
            }
            .sheet(isPresented: $contentVM.showCategoryDetailSheet, onDismiss: {
                withAnimation {
                    categoryVM.selectedCategory = nil
                }
            }) {
                CategoryDetailView(categoryVM: categoryVM)
            }
            .onChange(of: tabSelection) {
                withAnimation {
                    contentVM.appState = tabSelection
                }
            }
            .toolbar {
                Toolbar(contentVM: contentVM, transactionVM: transactionVM, categoryVM: categoryVM)
            }
        }
    }
}

#Preview {
    iOSContentView(contentVM: ContentViewModel(), transactionVM: TransactionViewModel(), categoryVM: CategoryViewModel())
}
#endif
