//
//  ContentView.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import SwiftUI

struct ContentView: View {
    
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            // VStack 的宽度由内部较宽的元素确定
            Text("0")
                .font(.system(size: 76))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .trailing)
                .lineLimit(1)
                .padding(.trailing,24)
                .minimumScaleFactor(0.5)
            // infinity 会尽可能占据容器的大小
            CalculatorButtonPad()
                .padding(.bottom)
        }
        .scaleEffect(scale)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().previewDevice("iPhone SE (3rd generation)")
        }
        
        
    }
}
