//
//  CalculatorButtonItem.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import SwiftUI

enum CalculatorButtonItem: Hashable {
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case multiply = "x"
        case divide = "÷"
        case equal = "="
    }
    
    enum Command: String {
        case percent = "%"
        case flip = "+/-"
        case clear = "AC"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
    
}

//MARK: - 由于不存在UI 与 Model 同步的问题 因此不需要ViewModel
extension CalculatorButtonItem {
    
    var title: String {
        switch self {
        case .digit(let int):
            return "\(int)"
        case .dot:
            return "."
        case .op(let op):
            return op.rawValue
        case .command(let command):
            return command.rawValue
        }
    }
    
    
    var size:CGSize {
        if case .digit(let value) = self,value == 0 {
            return .init(width: 88 * 2 + 8, height: 88)
        }
        return .init(width: 88, height: 88)
    }
    
    var forgroundColor: Color {
        switch self {
        case .command:
            return .black
        default:
            return .white
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit:
            return digitalColor
        case .dot:
            return digitalColor
        case .op(let op):
            return operatorColor
        case .command(let command):
            return commandColor
        }
    }
    
}
