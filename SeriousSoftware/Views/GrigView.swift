//
//  GrigView.swift
//  SeriousSoftware
//
//  Created by Alex Bibikov on 29.04.2022.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let end = CGPoint(x: rect.maxX, y: rect.midY)

        return Path { p in
            p.move(to: start)
            p.addLine(to: end)
        }
    }
}

struct GrigView: View {
    let range: ClosedRange<Double>
    let numberOfSteps: Int
    let dashColor: Color
    let textColor: Color
    let valuesTail: String

    var body: some View {
        VStack {
            let values = Array(range.separate(numberOfSteps: numberOfSteps).reversed())
            ForEach(0..<values.count) { index in
                HStack {
                    Text("\(values[index], specifier: "%.1f")\(valuesTail)")
                        .foregroundColor(textColor)
                        .font(.footnote)
                    Line()
                        .stroke(dashColor, style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .frame(height: 1)
                }
                if index + 1 < values.count {
                    Spacer()
                }
            }
        }
    }

    init(range: ClosedRange<Double>,
         numberOfSteps: Int = 7,
         dashColor: Color = Color.gray,
         textColor: Color = Color.black,
         valuesTail: String) {
        self.range = range
        self.numberOfSteps = numberOfSteps
        self.dashColor = dashColor
        self.textColor = textColor
        self.valuesTail = valuesTail
    }
}

struct GrigView_Previews: PreviewProvider {
    static var previews: some View {
        GrigView(range: 0...5, valuesTail: "%")
    }
}
