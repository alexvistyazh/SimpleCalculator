//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Aliaksei Vistiazh on 10/6/17.
//  Copyright © 2017 Aliaksei Vistiazh. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case EqualOperation
    }
    
    private var operations: [String: Operation] = [
        "π": Operation.Constant(Double.pi),
        "e": Operation.Constant(M_E),
        "±": Operation.UnaryOperation({ -$0 }),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "sin": Operation.UnaryOperation(sin),
        "tan": Operation.UnaryOperation(tan),
        "1/x": Operation.UnaryOperation({ 1 / $0 }),
        "x×x": Operation.UnaryOperation({ $0 * $0 }),
        "+": Operation.BinaryOperation(+),
        "-": Operation.BinaryOperation(-),
        "÷": Operation.BinaryOperation(/),
        "×": Operation.BinaryOperation(*),
        "=": Operation.EqualOperation
    ]
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch (operation) {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let foo):
                notEndedBiOp = Optional.none
                accumulator = foo(accumulator)
            case .BinaryOperation(let foo):
                performNotEndedBiOp()
                notEndedBiOp = NotEndedBinaryOperation(function: foo, firstOperand: accumulator)
            case .EqualOperation:
                performNotEndedBiOp()
            }
        }
    }
    
    func performNotEndedBiOp() {
        if let op = notEndedBiOp {
            accumulator = op.function(op.firstOperand, accumulator)
            notEndedBiOp = Optional.none
        }
    }
    
    private struct NotEndedBinaryOperation {
        var function: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var notEndedBiOp: NotEndedBinaryOperation?
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
