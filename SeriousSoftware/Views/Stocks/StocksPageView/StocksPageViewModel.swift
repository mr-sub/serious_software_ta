//
//  StocksPageViewModel.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import Foundation

final class StocksPageViewModel: ObservableObject {
    @Published private(set) var stockViewModels: [StocksViewModel]

    init(stockViewModels: [StocksViewModel]) {
        self.stockViewModels = stockViewModels
    }
    
}
