//
//  ContentView.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import SwiftUI

struct ContentView: View {
    // @State 内部会转换成 getter setter，对其赋值会触发View 的刷新,只能在属性本身被修改时触发UI刷新,适合值语意
    // @State 不可以在body 外部改变State 的值 对于Model 复杂的情况，其中一俩个需要触发UI刷新 ObservedObject 和 ObservableObject是好的解决方案
    @EnvironmentObject
    private var model: CalculatorModel
    @State
    private var editingHistory = false
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            // VStack 的宽度由内部较宽的元素确定
            Button("操作履历: \(model.history.count)") {
                self.editingHistory = true
            }
            .sheet(isPresented: self.$editingHistory) {
                HistoryView(model:self.model)
            }
            Text(model.brain.output)
                .font(.system(size: 76))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .trailing)
                .lineLimit(1)
                .padding(.trailing,24)
                .minimumScaleFactor(0.5)
            // infinity 会尽可能占据容器的大小
            CalculatorButtonPad() // 对于 @ 修饰的属性 使用$ 称为 投影属性 对于 @State @Binding 投影属性就是自身的Binding类型
                .padding(.bottom)
        }
        .scaleEffect(scale)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(CalculatorModel())
            
        }
        
        
    }
}
