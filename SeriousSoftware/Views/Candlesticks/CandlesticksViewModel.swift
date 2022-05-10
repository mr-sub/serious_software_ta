//
//  CandlesticksViewModel.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import Foundation
import SwiftUI

enum CandlestickType: String, CaseIterable {
    case aapl = "AAPL"
    case msft = "MSFT"
    case spy = "SPY"

    var stockColor: Color {
        return self.rawValue.stockColor
    }
}

struct CandlestickTypeViewModel: Hashable {
    let title: String
    let type: CandlestickType
}

final class CandlesticksViewModel: ObservableObject {
    private let parser: StockParsing

    private var lowPrice = 0.0

    private var hightPrice = 0.0

    @Published private(set) var items: [Candlestick] = []

    var candlestickType: CandlestickType = .aapl {
        didSet {
            getStocks()
        }
    }

    var candlesticksPriceRange: ClosedRange<Double> { lowPrice...hightPrice }

    var candlestickTypeViewModels: [CandlestickTypeViewModel] {
        return CandlestickType
            .allCases
            .map { CandlestickTypeViewModel(title: $0.rawValue, type: $0) }
    }

    init(parser: StockParsing) {
        self.parser = parser
        getStocks()
    }

    private func getStocks() {
        do {
            let stocks = try self.parser.parse()
            let stock = stocks.first(where: { $0.symbol == candlestickType.rawValue })
            let items = stock?.candlesticks ?? []

            guard !items.isEmpty else { return }

            lowPrice = items[0].lowPrice
            hightPrice = items[0].hightPrice

            for item in items {
                if item.lowPrice < lowPrice {
                    lowPrice = item.lowPrice
                }
                if item.hightPrice > hightPrice {
                    hightPrice = item.hightPrice
                }
            }
            self.items = items
        } catch  {}
    }
}
