//
//  Data.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import Foundation

extension Data {
    static var responseQuotesWeekJsonData: Data {
        guard let url = Bundle.main.url(forResource: "responseQuotesWeek", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        return data
    }

    static var responseQuotesMonthJsonData: Data {
        guard let url = Bundle.main.url(forResource: "responseQuotesMonth", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        return data
    }
}
