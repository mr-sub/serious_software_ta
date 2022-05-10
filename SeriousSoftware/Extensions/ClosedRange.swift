//
//  ClosedRange.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 29.04.2022.
//

import Foundation

extension ClosedRange where Bound == Double {
    var height: Double {
        var rangeHeight = upperBound - lowerBound
        if lowerBound <= 0 && upperBound <= 0 {
            rangeHeight = abs(lowerBound + upperBound)
        } else if lowerBound < 0 && upperBound >= 0 {
            rangeHeight = upperBound + abs(lowerBound)
        }
        return rangeHeight
    }

    func separate(numberOfSteps: Int) -> [Double] {
        guard numberOfSteps > 0 else { return [] }

        let step = height / Double(numberOfSteps - 1)
        var result: [Double] = []

        for index in 0..<numberOfSteps {
            let value = lowerBound + step * Double(index)
            result.append(value)
        }
        return result
    }
}
