//
//  HomeView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var contentVM: ContentViewModel
    @State var transactionVM: TransactionViewModel
    @State var categoryVM: CategoryViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            FinReportView(transactionVM: transactionVM)
        Spacer()
        }
        .padding(12)
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView(contentVM: ContentViewModel(), transactionVM: TransactionViewModel(), categoryVM: CategoryViewModel())
}
