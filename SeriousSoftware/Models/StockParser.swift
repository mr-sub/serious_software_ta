//
//  StockParser.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 28.04.2022.
//

import Foundation

fileprivate struct StockResponse: Decodable {
    let quoteSymbols: [Stock]

    enum CodingKeys: String, CodingKey {
        case content
    }

    enum QuoteSymbolsKeys: String, CodingKey {
        case quoteSymbols
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let contentContainer = try container.nestedContainer(keyedBy: QuoteSymbolsKeys.self, forKey: .content)
        quoteSymbols = try contentContainer.decode([Stock].self, forKey: .quoteSymbols)
    }
}

protocol StockParsing {
    func parse() throws -> [Stock]
}

final class StockParser: StockParsing {
    private let jsonData: Data

    init(jsonData: Data) {
        self.jsonData = jsonData
    }

    func parse() throws -> [Stock] {
        do {
            let response = try JSONDecoder().decode(StockResponse.self, from: jsonData)
            return response.quoteSymbols
        } catch {
            throw error
        }
    }
}
