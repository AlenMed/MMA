//
//  iOSContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

#if os(iOS)
struct iOSContentView: View {
    @State var contentVM: ContentViewModel
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
                
                TransactionListView()
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
            .sheet(isPresented: $contentVM.showNewCategorySheet) {
                NewCategoryView()
            }
            .onChange(of: tabSelection) {
                withAnimation {
                    contentVM.appState = tabSelection
                }
            }
            .toolbar {
                ToolbarItem {
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
                            .foregroundStyle(Color.accentColor)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    iOSContentView(contentVM: ContentViewModel())
}
#endif
