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
    var action:()->Void
    var body: some View {
        Button {
           action()
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

