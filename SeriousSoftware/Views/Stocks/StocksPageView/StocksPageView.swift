//
//  StocksPageView.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import SwiftUI

struct StocksPageView: View {
    var viewModel: StocksPageViewModel

    var body: some View {
        NavigationView {
            TabView() {
                ForEach(viewModel.stockViewModels) { viewModel in
                    StocksView(viewModel: viewModel)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .navigationTitle("Stocks")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct StocksPageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StocksViewModel(parser: StockParser(jsonData: .responseQuotesMonthJsonData), title: "Test")
        let pageViewModel = StocksPageViewModel(stockViewModels: [viewModel])
        StocksPageView(viewModel: pageViewModel)
    }
}
