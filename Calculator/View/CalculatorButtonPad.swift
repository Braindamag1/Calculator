//
//  CalculatorButtonPad.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import SwiftUI

struct CalculatorButtonPad: View {
    //@Biinding 将值语意的属性转换为引用寓意
    //@Binding var brain: CalculatorBrain
    //var model: CalculatorModel
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear),.command(.flip),.command(.percent),.op(.divide)],
        [.digit(7),.digit(8),.digit(9),.op(.multiply)],
        [.digit(4),.digit(5),.digit(6),.op(.minus)],
        [.digit(1),.digit(2),.digit(3),.op(.plus)],
        [.digit(0),.dot,.op(.equal)]
    
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad,id: \.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}

