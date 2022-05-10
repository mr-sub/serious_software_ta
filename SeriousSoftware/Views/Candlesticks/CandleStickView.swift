//
//  CandleStickView.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 09.05.2022.
//

import SwiftUI

struct CandleStickView: View {
    struct ColorConfig {
        let increasingColor: Color
        let decreasingColor: Color

        static var defaultConfig: ColorConfig {
            return ColorConfig(increasingColor: .green, decreasingColor: .red)
        }
    }

    let candlestick: Candlestick
    let colorConfig: ColorConfig
    let candlesticksPriceRange: ClosedRange<Double>

    var body: some View {
        GeometryReader { geometry in
            let centerX = geometry.size.width / 2
            let startY = calculateOffset(value: candlestick.hightPrice, geometry: geometry)
            let endY = calculateOffset(value: candlestick.lowPrice, geometry: geometry)
            let squareRect = squareRect(geometry: geometry)
            let linesPath = Path { path in
                path.move(to: CGPoint(x: centerX, y: startY))
                path.addLine(to: CGPoint(x: centerX, y: squareRect.minY))
                path.move(to: CGPoint(x: centerX, y: squareRect.maxY))
                path.addLine(to: CGPoint(x: centerX, y: endY))
            }
            let squarePath = Path { path in
                path.addRect(squareRect)
            }

            if candlestick.closePrice > candlestick.openPrice {
                linesPath
                    .stroke(colorConfig.increasingColor, style: StrokeStyle(lineWidth: 1, lineJoin: .round))
                squarePath
                    .fill(colorConfig.increasingColor)
            } else {
                linesPath
                    .stroke(colorConfig.decreasingColor, style: StrokeStyle(lineWidth: 1, lineJoin: .round))
                squarePath
                    .stroke(colorConfig.decreasingColor, style: StrokeStyle(lineWidth: 1, lineJoin: .round))
                squarePath
                    .fill(colorConfig.decreasingColor)
            }
        }
    }

    private func calculateOffset(value: CGFloat, geometry: GeometryProxy) -> CGFloat {
        let priceHeight = candlesticksPriceRange.height
        let offset = value - candlesticksPriceRange.lowerBound
        let ratio = offset / priceHeight
        return geometry.size.height - (ratio * geometry.size.height)
    }

    private func squareRect(geometry: GeometryProxy) -> CGRect {
        let maxPrice = max(candlestick.openPrice, candlestick.closePrice)
        let minPrice = min(candlestick.openPrice, candlestick.closePrice)
        let height = maxPrice - minPrice

        guard height > 0 else { return .zero }

        let y = calculateOffset(value: maxPrice, geometry: geometry)
        let maxY = calculateOffset(value: minPrice, geometry: geometry)
        let squareHeight = maxY - y

        return CGRect(x: 0, y: y, width: geometry.size.width, height: squareHeight)
    }
}

struct CandleStickView_Previews: PreviewProvider {
    static var previews: some View {
        CandleStickView(
            candlestick:
                Candlestick(symbol: "TEST",
                            openPrice: 9,
                            hightPrice: 12,
                            closePrice: 8,
                            lowPrice: 0,
                            timeStamp: 111111),
            colorConfig: .defaultConfig,
            candlesticksPriceRange: 0...24
        )
    }
}
