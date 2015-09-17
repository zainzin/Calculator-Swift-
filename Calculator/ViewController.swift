//
//  ViewController.swift
//  Calculator
//
//  Created by Zain Hatim on 9/10/15.
//  Copyright (c) 2015 Zain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBAction func numberPressed(sender: AnyObject) {
        let digit = sender.currentTitle!
        if userIsTyping{
            display.text = display.text! + digit!
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    @IBAction func calculationButton(sender: AnyObject) {
        let operation = sender.currentTitle!
        if userIsTyping {
            returnButtonPressed()
        }
        switch operation {
        case "×"?:
            doCalculation{ $0 * $1 }
        case "÷"?:
            doCalculation{ $1 / $0 }
        case "−"?:
            doCalculation{ $1 - $0 }
        case "+"?:
            doCalculation{ $0 + $1 }
        default:
            break
        }
        
    }
    
    func doCalculation(calculation: (Double, Double) -> Double ){
        if operandStack.count >= 2 {
            displayValue = calculation(operandStack.removeLast(), operandStack.removeLast())
            returnButtonPressed()
        }
        
    }
    @IBAction func clearButton(sender: AnyObject) {
        operandStack.removeAll()
        display.text = "0"
        userIsTyping = false
        
    }
    var operandStack = Array<Double>()
    
    var userIsTyping = false
    
    @IBAction func returnButtonPressed() {
        
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        userIsTyping = false
        
    }
    
    var displayValue: Double{
        get{
           return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        } set {
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}