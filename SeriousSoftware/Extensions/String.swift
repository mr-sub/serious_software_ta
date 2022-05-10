//
//  String.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import SwiftUI

extension String {
    var stockColor: Color {
        if self == "AAPL" {
            return .red
        } else if self == "MSFT" {
            return .green
        } else if self == "SPY" {
            return .cyan
        }
        return .accentColor
    }
}
