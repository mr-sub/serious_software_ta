//
//  SeriousSoftwareApp.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 28.04.2022.
//

import SwiftUI

@main
struct SeriousSoftwareApp: App {
    let quotesWeekParser = StockParser(jsonData: Data.responseQuotesWeekJsonData)
    let quotesMonthParser = StockParser(jsonData: Data.responseQuotesMonthJsonData)

    var body: some Scene {
        WindowGroup {
            TabView {
                CandlesticksView(viewModel: CandlesticksViewModel(parser: quotesWeekParser))
                    .tabItem {
                        Label("Candlesticks", systemImage: "chart.bar.xaxis")
                    }

                let viewModel1 = StocksViewModel(parser: StockParser(jsonData: .responseQuotesWeekJsonData), title: "Week")
                let viewModel2 = StocksViewModel(parser: StockParser(jsonData: .responseQuotesMonthJsonData), title: "Month")
                let pageViewModel = StocksPageViewModel(stockViewModels: [viewModel1, viewModel2])

                StocksPageView(viewModel: pageViewModel)
                    .tabItem {
                        Label("Stocks", systemImage: "chart.xyaxis.line")
                    }
            }
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
                UITabBar.appearance().isTranslucent = true
                UITabBar.appearance().unselectedItemTintColor = .black
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
                UINavigationBar.appearance().isTranslucent = false
            }
            .accentColor(.orange)
        }
    }
}
