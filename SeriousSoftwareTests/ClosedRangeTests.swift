//
//  ClosedRangeTests.swift
//  SeriousSoftwareTests
//
//  Created by Alex Bibikov on 29.04.2022.
//

import XCTest
@testable import SeriousSoftware

class ClosedRangeTests: XCTestCase {
    func testHeight() {
        let range1: ClosedRange<Double> = -15...0
        let height1 = range1.height
        XCTAssertEqual(height1, 15)

        let range2: ClosedRange<Double> = -15...15
        let height2 = range2.height
        XCTAssertEqual(height2, 30)

        let range3: ClosedRange<Double> = 0...15
        let height3 = range3.height
        XCTAssertEqual(height3, 15)
    }

    func testSeparation() {
        let range: ClosedRange<Double> = 0...15
        let separation = range.separate(numberOfSteps: 3)

        XCTAssertEqual(separation[0], 0)
        XCTAssertEqual(separation[1], 7.5)
        XCTAssertEqual(separation[2], 15)
    }
}
