//
//  ViewController.swift
//  Calculator
//
//  Created by Aliaksei Vistiazh on 10/4/17.
//  Copyright © 2017 Aliaksei Vistiazh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var digits: UILabel!
    private var wasTyped = false
    
    private var displayValue: Double {
        get {
            return Double(digits.text!)!
        }
        set {
            digits.text = String(newValue)
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
  
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        brain.setOperand(operand: displayValue)
        wasTyped = false
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
    }
    
    func checkCorrectness(text: String) -> Bool {
        Double(
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        if !wasTyped {
            digits.text = sender.currentTitle!
        } else {
            digits.text = digits.text! + sender.currentTitle!
        }
        wasTyped = true
    }
}

