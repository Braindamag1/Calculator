//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import Foundation

enum CalculatorBrain {
    case left(String)
    case leftOp(left: String,
                op: CalculatorButtonItem.Op)
    case leftOpRight(left: String,
                     op:CalculatorButtonItem.Op,
                     right:String)
    case error
    
    var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0 // 最小的小数位数
        f.maximumFractionDigits = 8 // 最大的小数位数
        f.numberStyle = .decimal
        return f
    }
    
    var output: String {
        let result: String
        switch self {
        case .left(let left ):
            result = left
        case .leftOp(let left,_):
            result = left
        case .leftOpRight(_,_, let right):
            result = right
        case .error:
            return "Error"
        }
        guard let value = Double(result) else {return "Error"}
        return formatter.string(from: value as NSNumber)!
    }
    
    @discardableResult
    func apply(item: CalculatorButtonItem)-> CalculatorBrain {
        switch item {
        case .digit(let num):
            return apply(num: num)
        case .dot:
            return applyDot()
        case .op(let op):
            return apply(op: op)
        case .command(let command):
            return apply(command: command)
        }
    }
    
    
    private func apply(num:Int)->CalculatorBrain {
        switch self {
        case .left(let left):
            return .left(left.apply(num: num))
        case .leftOp(let left, let op):
            return .leftOpRight(left: left, op: op, right: "0".apply(num: num))
        case .leftOpRight(let left, let op, let right):
            return .leftOpRight(left: left, op: op, right: right.apply(num: num))
        case .error:
            return .left("0".apply(num: num))
        }
    }
    
    
    private func applyDot()-> CalculatorBrain {
        switch self {
        case .left(let left):
            return .left(left.applyDot())
        case .leftOp(let left, let op):
            return .leftOpRight(left: left, op: op, right: "0".applyDot())
        case .leftOpRight(let left, let op, let right):
            return .leftOpRight(left: left, op: op, right: right.applyDot())
        case .error:
            return .left("0".applyDot())
        }
    }
    
    private func apply(op: CalculatorButtonItem.Op)-> CalculatorBrain {
        switch self {
        case .left(let left):
            switch op {
            case .plus,.minus,.multiply,.divide:
                return .leftOp(left: left, op: op)
            case .equal:
                return self
            }
        case .leftOp(let left, let currentOP):
            switch op {
            case .plus,.minus,.multiply,.divide:
                return .leftOp(left: left, op: op)
            case .equal:
                if let res = currentOP.calculate(l: left, r: left) {
                    return .leftOp(left: res, op: currentOP)
                } else {
                    return .error
                }
            }
        case .leftOpRight(let left, let currentOp, let right):
            switch op {
            case .plus,.minus,.multiply,.divide:
                if let res =  op.calculate(l: left, r: right) {
                    return .leftOp(left: res, op: op)
                }
            case .equal:
                if let res = currentOp.calculate(l: left, r: right) {
                    return .left(res)
                } else {
                    return .error
                }
            }
        case .error:
            return self
        }
    }
    
    private func apply(command: CalculatorButtonItem.Command)-> CalculatorBrain {
        switch command {
        case .percent:
            <#code#>
        case .flip:
            switch self {
            case .left(let left):
                return .left(left.flipped())
            case .leftOp(let left, let op):
                return .leftOpRight(left: left, op: op, right: "-0")
            case .leftOpRight(let left, let op, let right):
                return .leftOpRight(left: left, op: op, right: right.flipped())
            case .error:
                return .left("-0")
            }
        case .clear:
            return .left("0")
        }
    }
}

typealias CalculatorState = CalculatorBrain
typealias CalculatorStateAction = CalculatorButtonItem

/// 纯函数指返回值只有调用的参数决定，不依赖与任何系统状态，也不改变作用域外的变量状态
/// Swift UI 强调single source of truth 一个稳定可测试的model是app状态状态清晰重要的保证
struct Reducer {
    static func reduce(state: CalculatorState,
                       action: CalculatorStateAction)-> CalculatorState {
        return state.apply(item: action)
    }
}


extension String {
    func apply(num: Int)->String {
        return self == "0" ? "\(num)" : "\(self)\(num)"
    }
    
    func applyDot()-> String {
        return containDot ? self : "\(self)."
    }
    
    func flipped()-> String {
        if startWithNagivate {
            var s = self
            s.removeFirst()
            return s
        } else {
            return "-\(self)"
        }
    }
    
    func percentaged()-> String {
        return String(Double(self)! / 100)
    }
    
    var containDot: Bool {
        return contains(".")
    }
    
    var startWithNagivate:Bool {
        return starts(with: "-")
    }
    
}


extension CalculatorButtonItem.Op {
    func calculate(l:String,r:String)-> String? {
        guard let left = Double(l),
              let right = Double(r) else {return nil}
        let result: Double?
        switch self {
        case .plus: result = left + right
        case .minus: result = left - right
        case .multiply: result = left * right
        case .divide: result = right == 0 ? nil : left / right
        case .equal: fatalError()
        }
        return result.map({String($0)})
    }
}
