//
//  CandlestickView.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import SwiftUI

struct CandlesticksView: View {
    @State private var showingOptions = false
    
    var body: some View {
        NavigationView {
            ZStack {
                let range = viewModel.candlesticksPriceRange
                GrigView(range: range, textColor: Color.white, valuesTail: "")
                    .background(.black)
                ScrollView(.horizontal) {
                    HStack(spacing: 1) {
                        ForEach(viewModel.items) { candlestick in
                            VStack {
                                CandleStickView(candlestick: candlestick,
                                                colorConfig: .defaultConfig,
                                                candlesticksPriceRange: range)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
            }
            .navigationTitle("Candlesticks")
            .toolbar {
                Button {
                    showingOptions = true
                } label: {
                    HStack(spacing: 3) {
                        Text(viewModel.candlestickType.rawValue)
                            .padding(3)
                            .foregroundColor(viewModel.candlestickType.stockColor)
                    }
                }
                .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .visible) {
                    ForEach(viewModel.candlestickTypeViewModels, id: \.self) { item in
                        Button(item.title) {
                            viewModel.candlestickType = item.type
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ObservedObject private(set) var viewModel: CandlesticksViewModel
}

struct CandlestickView_Previews: PreviewProvider {
    static var previews: some View {
        CandlesticksView(viewModel: CandlesticksViewModel(parser: StockParser(jsonData: Data.responseQuotesWeekJsonData)))
    }
}
