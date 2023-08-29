//
//  MainViewController.swift
//  Math
//
//  Created by vitasiy on 27/08/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var firstNumLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var secondNumLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var informView: UIView!
    @IBOutlet weak var informLabel: UILabel!
    
    var level: Int!
    
    var pName: String!
    
    private var player = Player(name: "Player", attempts: [])
    
    private var firstNum = 0
    private var secondNum = 0
    
    private var score = 0
    private var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.name = pName
        playerName.text = player.name + " lvl:\(level!)"
        newTusk()
    }
    
    private func newTusk() {
        
        level = Int(score / 10)
        
        
//        if counter >= 9 {
//            level += Double(score / counter) > 0.8 ?  1 : -1
//            if level < 0  { level = 0 }
//            if level > 10 { level = 10 }
//        }
        
        playerName.text = player.name + " lvl:\(level!)"
        
        timerLabel.text = "\(score)/\(counter)"
        counter += 1
        inputTextField.text = ""
        var range = 0...99
        switch level {
        case 0:
            range = 0...10
        case 1:
            range = 0...15
        case 2:
            range = 0...20
        case 3:
            range = 0...30
        case 4:
            range = 10...30
        case 5:
            range = 15...50
        case 6:
            range = 10...80
        case 7:
            range = 0...90
        case 8:
            range = 30...99
        case 9:
            range = 60...99
        default:
            range = 22...99
        }
        
        let a = Int.random(in: range)
        let b = Int.random(in: range)
        
        firstNum = max(a, b)
        secondNum = min(a, b)
        
        firstNumLabel.text = "\(firstNum)"
        secondNumLabel.text = "\(secondNum)"
        operationLabel.text = Bool.random() ? "+" : "-"
    }
    
    private func operation() -> Int {
        operationLabel.text == "+" ? 1 : -1
    }
    
    private func showInfoView(isRight: Bool) {
        informView.isHidden = false
        informLabel.isHidden = false
        if isRight {
            informView.backgroundColor = UIColor(red: 0.01, green: 0.89, blue: 0.01, alpha: 0.5)
            informLabel.text = "RIGHT!"
        } else {
            informView.backgroundColor = UIColor(red: 1, green: 0.01, blue: 0.01, alpha: 0.5)
            informLabel.text = "WRONG!!"
        }
        
    }
    
    private func hideInfoView() {
        informView.isHidden = true
        informLabel.isHidden = true
    }
    
    private func checkResult() {
        guard let inputedResult = inputTextField.text else { return }
        
        if Int(inputedResult) == firstNum + secondNum * operation() {
            showInfoView(isRight: true)
            score += 1
            let attempt = Attempt(counter: counter, time: "", solved: score, level: level)
            player.attempts.append(attempt)
            print("")
            print(player)
            print("")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hideInfoView()
            }
            newTusk()
        } else {
            showInfoView(isRight: false)
            let attempt = Attempt(counter: counter, time: "", solved: score, level: level)
            player.attempts.append(attempt)
            print("")
            print(player)
            print("")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hideInfoView()
            }
            newTusk()
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        checkResult()
    }
    
    
}

extension MainViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkResult()
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
}

