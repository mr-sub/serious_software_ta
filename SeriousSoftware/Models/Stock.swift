//
//  Stock.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 28.04.2022.
//

import Foundation

struct Stock: Decodable {
    struct Performance {
        let max: Double
        let min: Double
        let percentages: [Double]
        let symbol: String

        enum Mode: String, CaseIterable {
            case open
            case close
            case hight
            case low
            case volume
        }
    }

    let symbol: String
    let timestamps: [Int]
    let opens: [Double]
    let closures: [Double]
    let highs: [Double]
    let lows: [Double]
    let volumes: [Double]
}

extension Stock {
    func performance(type: Performance.Mode) -> Stock.Performance {
        switch type {
        case .open:
            return calculatePerformance(items: opens)
        case .close:
            return calculatePerformance(items: closures)
        case .hight:
            return calculatePerformance(items: highs)
        case .low:
            return calculatePerformance(items: lows)
        case .volume:
            return calculatePerformance(items: volumes)
        }
    }

    private func calculatePerformance(items: [Double]) -> Stock.Performance {
        guard !items.isEmpty else { return .init(max: 0, min: 0, percentages: [], symbol: symbol) }

        let openPrice = items[0]
        var percentages: [Double] = []
        var max = 0.0
        var min = 0.0

        for closePrice in items {
            let percentage = ((closePrice - openPrice) / openPrice) * 100
            if percentage > max {
                max = percentage
            }
            if percentage < min {
                min = percentage
            }
            percentages.append(percentage)
        }
        return .init(max: max, min: min, percentages: percentages, symbol: symbol)
    }
}

extension Stock {
    var candlesticks: [Candlestick] {
        var result: [Candlestick] = []

        for (index, timestamp) in timestamps.enumerated() {
            guard canAddCandlestick(index: index) else { continue }
            let candlestick = Candlestick(symbol: symbol,
                                          openPrice: opens[index],
                                          hightPrice: highs[index],
                                          closePrice: closures[index],
                                          lowPrice: lows[index],
                                          timeStamp: timestamp)
            result.append(candlestick)
        }
        return result
    }

    private func canAddCandlestick(index: Int) -> Bool {
        guard index < opens.count
                && index < closures.count
                && index < highs.count
                && index < lows.count else {
            return false
        }
        return true
    }
}
