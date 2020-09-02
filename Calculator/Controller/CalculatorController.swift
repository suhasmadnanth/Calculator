//
//  CalculatorController.swift
//  Calculator
//
//  Created by admin on 08/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Cocoa

class CalculatorController: NSViewController {
    
    
    @IBOutlet weak var numberLabel: NSTextField!
    var isNumberPressedFinished : Bool = true
    private var calculateLogic = CalculateLogic()
    var calculate = CalculateModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func numberPressed(_ sender: NSButton) {
        if isNumberPressedFinished {
            numberLabel.stringValue = sender.title
            isNumberPressedFinished = false
        } else{
            if sender.title == "." {
                if numberLabel.stringValue == "." {
                    return
                } else {
                guard let currentDisplayValue = Double(numberLabel.stringValue) else {
                    fatalError("Unable to convert display value to Double")
                }
                let isInt = floor(currentDisplayValue) == currentDisplayValue
                if !isInt {
                    return
                }
                numberLabel.stringValue = numberLabel.stringValue + sender.title
            }
            } else {
                numberLabel.stringValue = numberLabel.stringValue + sender.title
            }
        }
    }
    
    
    @IBAction func operandsPressed(_ sender: NSButton) {
        isNumberPressedFinished = true
        if let number = Double(numberLabel.stringValue){
            calculateLogic.setCurrentNumber(number: number)
            if let displayValue = calculateLogic.performCalculation(symbol: sender.title){
                numberLabel.stringValue = String(displayValue)
            }
        }
    }
    
}
