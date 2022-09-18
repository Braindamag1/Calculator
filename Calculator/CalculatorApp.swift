//
//  CalculatorApp.swift
//  Calculator
//
//  Created by braindamage on 2022/9/17.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CalculatorModel())
        }
    }
}
