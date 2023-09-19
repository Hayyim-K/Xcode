//
//  Model.swift
//  Math
//
//  Created by vitasiy on 28/08/2023.

import Foundation

struct Player: Codable {
    var name: String = "Player"
    var tasks: [Task] = []
    var score: Int = 0
    var shownTasks: Int = 0
    var lives: Int = 10
    var level: Int = 0
    var regime: Int = 0
    var time: Double = 0
    var date: String = ""
}

struct Task: Codable {
    var firstNum: Int
    var secondNum: Int
    var operation: String
    var inputedResult: Int
    
    func getStringTask() -> String {
        "\(firstNum) \(operation) \(secondNum) = \(inputedResult)"
    }
    
    mutating func result() -> Int {
        
        switch operation {
        case "+": return firstNum + secondNum
        case "-": return firstNum - secondNum
        case "*": return firstNum * secondNum
        case "/": return firstNum / secondNum
        default:
            operation = "+"
            return firstNum + secondNum
        }
    }
}

