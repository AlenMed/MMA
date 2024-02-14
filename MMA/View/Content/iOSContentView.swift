//
//  iOSContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

struct iOSContentView: View {
    @State var contentVM: ContentViewModel
    @State private var tabSelection: Int = 1
    
    var body: some View {
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
        .onChange(of: tabSelection) {
            withAnimation {
                contentVM.appState = tabSelection
            }
        }
    }
}

#Preview {
    iOSContentView(contentVM: ContentViewModel())
}
