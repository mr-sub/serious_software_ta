//
//  StocksViewModel.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 28.04.2022.
//

import Foundation
import SwiftUI

struct StockPerformanceViewModelItem: Identifiable {
    fileprivate let performance: Stock.Performance
    var id: String { performance.symbol }
    var dataPoints: [Double] { performance.percentages }
    var stockColor: Color { performance.symbol.stockColor }
    var symbol: String { performance.symbol }
}

struct StocksPerformanceViewModel: Identifiable {
    let id: String
    let items: [StockPerformanceViewModelItem]
    let max: Double
    let min: Double

    init(stocks: [Stock], performanceMode: Stock.Performance.Mode) {
        let performances = stocks.map { $0.performance(type: performanceMode) }
        var min: Double = 0
        var max: Double = 0
        var id = ""
        var viewModelItems: [StockPerformanceViewModelItem] = []

        for item in performances {
            if item.min < min {
                min = item.min
            }
            if item.max > max {
                max = item.max
            }
            id += item.symbol
            viewModelItems.append(StockPerformanceViewModelItem(performance: item))
        }

        self.min = min
        self.max = max
        self.id = id
        self.items = viewModelItems
    }

}

enum StockType {
    case week
    case month
}

struct PerformanceModeViewModel: Hashable {
    let title: String
    let mode: Stock.Performance.Mode
}

final class StocksViewModel: ObservableObject, Identifiable {
    var stockType: StockType = .month

    var currentPerformanceModeTitle: String { performanceMode.rawValue }

    var performanceMode: Stock.Performance.Mode = .open {
        didSet {
            getStocks()
        }
    }

    var performanceModes: [PerformanceModeViewModel] {
        return Stock.Performance
            .Mode
            .allCases
            .map { PerformanceModeViewModel(title: $0.rawValue, mode: $0)  }
    }

    @Published private(set) var performance = StocksPerformanceViewModel(stocks: [], performanceMode: .open)

    private(set) var title: String

    init(parser: StockParsing, title: String) {
        self.parser = parser
        self.title = title

        getStocks()
    }

    private let parser: StockParsing

    private func getStocks() {
        do {
            let items = try parser.parse()
            self.performance = StocksPerformanceViewModel(stocks: items, performanceMode: performanceMode)
        } catch  { }
    }
}
