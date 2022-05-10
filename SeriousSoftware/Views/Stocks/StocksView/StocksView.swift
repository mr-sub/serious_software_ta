//
//  ContentView.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 28.04.2022.
//

import SwiftUI
import Combine

struct StocksView: View {
    @State private var showingOptions = false

    var body: some View {
        ZStack {
            let range: ClosedRange<Double> = viewModel.performance.min...viewModel.performance.max
            VStack(alignment: .leading) {
                Spacer(minLength: 15)

                HStack(alignment: .firstTextBaseline) {
                    ForEach(viewModel.performance.items) { perfomance in
                        Text(perfomance.symbol)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(perfomance.stockColor)
                    }
                    Spacer()
                    Button {
                        showingOptions = true
                    } label: {
                        HStack(spacing: 3) {
                            Text(viewModel.currentPerformanceModeTitle)
                                .padding(3)
                                .foregroundColor(.white)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                    }
                    .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .visible) {
                        ForEach(viewModel.performanceModes, id: \.self) { item in
                            Button(item.title) {
                                viewModel.performanceMode = item.mode
                            }
                        }
                    }
                }
                Spacer(minLength: 15)
                ZStack {
                    GrigView(range: range, textColor: Color.white, valuesTail: "%")
                    ForEach(viewModel.performance.items) { perfomance in
                        LineView(dataPoints: perfomance.dataPoints, color: perfomance.stockColor, range: range)
                            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
                    }
                }
            }
            .background(.black)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ObservedObject private(set) var viewModel: StocksViewModel
}

struct StocksView_Previews: PreviewProvider {
    static var previews: some View {
        StocksView(viewModel: StocksViewModel(parser: StockParser(jsonData: Data.responseQuotesWeekJsonData),
                                              title: "Week"))
    }
}
