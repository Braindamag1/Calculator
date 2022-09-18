//
//  CalculatorButtonRow.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import SwiftUI

struct CalculatorButtonRow: View {
    //@Binding var brain: CalculatorBrain
    @EnvironmentObject
    var model: CalculatorModel
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack(){
            /*
             ForEach 生成ViewCollection ，接受的数组必须满足Identifiable 若不满足 ForEach(_id:) 用 hashable 的keypath
             由于CalculatorButtonItem不满足Identifier，但是可以让自身作为Hashable 并在keyPath 传入自身
             */
            ForEach(row,id: \.self) { item in
                CalculatorButton(title: item.title, size: item.size, forgroundColor: item.forgroundColor, backgroundColor: item.backgroundColor) {
                    model.apply(item)
                }
            }
        }
    }
}

