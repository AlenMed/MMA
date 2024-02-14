//
//  MacOSContentView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

struct MacOSContentView: View {
    @State var contentVM: ContentViewModel
    
    var body: some View {
        NavigationSplitView(sidebar: {
            MacOSSidebar(contentVM: contentVM)
        }) {
            viewForAppState()
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
