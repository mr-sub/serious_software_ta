//
//  StockParserTests.swift
//  SeriousSoftwareTests
//
//  Created by Alex Bibikov on 28.04.2022.
//

import XCTest
@testable import SeriousSoftware

class StockParserTests: XCTestCase {
    func testParseMonthData() {
        let parser = StockParser(jsonData: Data.responseQuotesMonthJsonData)
        do {
            let items = try parser.parse()
            XCTAssertFalse(items.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testParseWeekData() {
        let parser = StockParser(jsonData: Data.responseQuotesWeekJsonData)
        do {
            let items = try parser.parse()
            XCTAssertFalse(items.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
