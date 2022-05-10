//
//  Candlestick.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import Foundation

struct Candlestick: Identifiable {
    var id: String { "\(timeStamp)_\(symbol)" }

    let symbol: String
    let openPrice: Double
    let hightPrice: Double
    let closePrice: Double
    let lowPrice: Double
    let timeStamp: Int
}

