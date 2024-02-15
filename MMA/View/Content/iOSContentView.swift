//
//  iOSContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

#if os(iOS)
struct iOSContentView: View {
    @Bindable var contentVM: ContentViewModel
    @State var transactionVM: TransactionViewModel
    @State var categoryVM: CategoryViewModel
    
    @State private var tabSelection: Int = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tabSelection) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(1)
                
                ChartView()
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                    }
                    .tag(2)
                
                TransactionListView(contentVM: contentVM, transactionVM: transactionVM)
                    .tabItem {
                        Image(systemName: "creditcard.fill")
                    }
                    .tag(3)
                
                CategoryListView()
                    .tabItem {
                        Image(systemName: "square.filled.on.square")
                    }
                    .tag(4)
            }
            .sheet(isPresented: $contentVM.showNewTransactionSheet) {
                NewTransactionView()
            }
            .sheet(isPresented: $contentVM.showTransactionDetailSheet) {
                TransactionDetailView(transactionVM: transactionVM)
            }
            .sheet(isPresented: $contentVM.showNewCategorySheet) {
                NewCategoryView()
            }
            .sheet(isPresented: $contentVM.showCategoryDetailSheet) {
                CategoryDetailView(categoryVM: categoryVM)
            }
            .onChange(of: tabSelection) {
                withAnimation {
                    contentVM.appState = tabSelection
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        //MARK: Decide action based on tab
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
                            .foregroundStyle(Color.accentColor)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    iOSContentView(contentVM: ContentViewModel(), transactionVM: TransactionViewModel(), categoryVM: CategoryViewModel())
}
#endif
