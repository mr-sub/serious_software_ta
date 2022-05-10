//
//  LineView.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 28.04.2022.
//

import SwiftUI

struct LineView: View {
    var dataPoints: [Double]
    let color: Color
    let range: ClosedRange<Double>

    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width

            Path { path in
                let startPoint = CGPoint(x: 0, y: ratio(for: 0, viewHeight: height))
                    .normilize(viewHeight: height)
                path.move(to: startPoint)
                for index in 1..<dataPoints.count {
                    let point = CGPoint(x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                                        y: ratio(for: index, viewHeight: height))
                        .normilize(viewHeight: height)
                    path.addLine(to: point)
                }
            }
            .stroke(color, style: StrokeStyle(lineWidth: 2, lineJoin: .round))
        }
        .padding(.vertical)
    }

    private func ratio(for index: Int, viewHeight: CGFloat) -> Double {
        let rangeHeight = range.height
        let value = dataPoints[index]
        let offset = value + abs(range.lowerBound)
        let percentOffset = offset / rangeHeight
        let result = viewHeight * percentOffset

        return result
    }
}

extension CGPoint {
    func normilize(viewHeight: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: viewHeight - y)
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(dataPoints: [0, 15, 10, 15], color: .red, range: -15.0...15.0)
    }
}
