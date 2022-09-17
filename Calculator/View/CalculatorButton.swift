//
//  CalculatorButton.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import SwiftUI

struct CalculatorButton: View {
    let title: String
    var size: CGSize
    var forgroundColor: Color
    var backgroundColor: Color
    var fontSize: CGFloat = 38
    var body: some View {
        Button {
            print(title)
        } label: {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(forgroundColor)
                .frame(width: size.width,height: size.height)
                .background(backgroundColor)
                .cornerRadius(size.height / 2)
        }

    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(title: "+", size: .init(width: 88, height: 88), forgroundColor: .white, backgroundColor: operatorColor, fontSize: 38)
    }
}
