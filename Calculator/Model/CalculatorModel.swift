//
//  CalculatorModel.swift
//  Calculator
//
//  Created by braindamage on 2022/9/18.
//

import Combine

class CalculatorModel: ObservableObject {
    
    //let objectWillChange = PassthroughSubject<Void,Never>() //提供以个send 方法通知外界有事情发生
    @Published // 编译器会自动生成并完成 objectWillChanged.send() 当 wilSet的时候
    var brain: CalculatorBrain = .left("0")
    
    @Published
    var history: [CalculatorButtonItem] = []
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }
    
    var historyDetail: String {
        history.map({$0.title}).joined()
    }
    
    var temporaryKept: [CalculatorButtonItem] = []
    
    var totalCount: Int {
        history.count + temporaryKept.count
    }
    
    var slidingIndex: Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }
    
    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index")
        let total = history + temporaryKept
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        brain = history.reduce(CalculatorBrain.left("0"), { result, item in
            result.apply(item:item)
        })
    }
}
