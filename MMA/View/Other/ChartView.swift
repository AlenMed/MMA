//
//  ChartView.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI
import SwiftData
import Charts


struct ChartView: View {
    @Query private var categories: [Category]
    @State private var chartSelection: Int?
    @State private var selectedCategoryName: String?
    
    
    enum ValueFilter {
        case positive
        case negative
        case all
    }
        
    var categoryTotal: [(String, Double?)] {
        return categories.map { ($0.name, $0.transactions?.reduce(0.0) { $0 + $1.amount }) }
    }
        
    func filterValues(_ filter: ValueFilter) -> [(String, Double?)] {
        switch filter {
        case .positive:
            return categoryTotal.filter { $0.1 ?? 0 > 0 }
        case .negative:
            return categoryTotal.filter { $0.1 ?? 0 < 0 }
        case .all:
            return categoryTotal
        }
    }
    
    var body: some View {
        VStack {
                HStack {
                    
                    VStack {
                        Chart {
                            ForEach(filterValues(.positive), id: \.0) { categoryName, amount in
                                SectorMark(angle: .value("Income", amount ?? 0),
                                           innerRadius: .ratio(0.5),
                                           outerRadius: selectedCategoryName == categoryName ? 120 : 250,
                                           angularInset: 1.5)
                                .foregroundStyle(by: .value("Category", categoryName))
                                .cornerRadius(4)
                            }
                        }
                        .padding(12)
                        .frame(minWidth: 120, maxWidth: 320, minHeight: 80, maxHeight: 180)
                        .chartLegend(position: .bottom, alignment: .center)
                        .chartAngleSelection(value: $chartSelection)
                        .onChange(of: chartSelection) {
                            if let chartSelection {
                                withAnimation {
                                    if let selectedCategory = getSelectedCategory(chartSelection) {
                                        selectedCategoryName = selectedCategory
                                    }
                                }
                            }
                        }
                    Spacer()
                    }
                    //MARK: END TOPLEADING CHART
//MARK: TEMP SPACER, WILL BE PUSHED ONCE ITEMS ARE ADDED
                Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 360)
                .background(.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 6))
        Spacer()
        }
        .padding(12)
        .navigationTitle("Charts")
    }
    
    private func getSelectedCategory(_ value: Int) -> String? {
        var cumulativeTotal: Int = 0
        for category in categories {
            if let transactions = category.transactions {
                let total = transactions.reduce(0) { $0 + ($1.amount) }
                cumulativeTotal += Int(total)
                if value < cumulativeTotal {
                    return category.name
                }
            }
        }
        return nil
    }
}

#Preview {
    ChartView()
}


