//
//  Calculate.swift
//  Calculator
//
//  Created by admin on 08/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct CalculateLogic {
    
    private var number: Double?
    private var previousNumber: Double?
    var calculate: CalculateModel?
    private var operand: String?
    
    mutating func setCurrentNumber(number: Double) {
        self.number = number
        self.calculate?.currentNumber = self.number
    }
    
    mutating func setPreviousNumber(previousNumber: Double, operand: String) {
        self.previousNumber = previousNumber
        self.operand = operand
    }
    
    mutating func performCalculation(symbol: String) -> Double? {
        if let currentDisplayValue = self.number {
            switch symbol {
            case "AC":
                self.calculate = CalculateModel(currentNumber: 0.0, storePreviousNumberAndOperand: nil, result: 0.0)
                return self.calculate?.result
            case "+/-":
                let output = currentDisplayValue * -1
                self.calculate = CalculateModel(currentNumber: self.number, storePreviousNumberAndOperand: nil, result: output)
                return self.calculate?.result
            case "%":
                let output = currentDisplayValue / 100
                self.calculate = CalculateModel(currentNumber: self.number, storePreviousNumberAndOperand: nil, result: output)
                return self.calculate?.result
            case "+", "-", "*", "/":
                setPreviousNumber(previousNumber: currentDisplayValue, operand: symbol)
                self.calculate = CalculateModel(currentNumber: self.number, storePreviousNumberAndOperand: (num1: self.previousNumber, operand: self.operand))
            case "=":
                if (self.calculate?.currentNumber) != nil {
                    if self.calculate?.storePreviousNumberAndOperand?.operand != nil {
                        let output = performOperation(calculate: self.calculate)
                        self.calculate?.result = output
                        return self.calculate?.result
                    }
                    else {
                        return currentDisplayValue
                    }
                }
                return nil
            default:
                return nil
            }
        }
        return nil
    }
    
    mutating func performOperation(calculate: CalculateModel?) -> Double? {
        if let currentNumber = calculate?.currentNumber, let previousNumber = self.calculate?.storePreviousNumberAndOperand?.num1 {
            switch operand {
            case "+":
                let output = previousNumber + currentNumber
                return output
            case "-":
                let output = previousNumber - currentNumber
                return output
            case "*":
            let output = previousNumber * currentNumber
            return output
            case "/":
            let output = previousNumber / currentNumber
            return output
            default:
                return nil
            }
        }
        return nil
    }
}
