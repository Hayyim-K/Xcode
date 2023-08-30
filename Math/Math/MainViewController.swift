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
    
    private var mistakes: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonOnKeyBoard()
        player.name = pName
        playerName.text = "lvl:\(level!)"
        newTusk()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let resultVC = segue.destination as? ResultsViewController else { return }
        
        player.score = score
        player.tasks = counter
        player.level = level
        
        resultVC.player = player
        resultVC.mistakes = mistakes
        
    }
    
    private func addButtonOnKeyBoard() {
        
        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        accessoryView.backgroundColor = UIColor.lightGray
        
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        accessoryView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor, constant: -16).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor).isActive = true
        inputTextField.inputAccessoryView = accessoryView
    }
    
    private func newTusk() {
        
        level = level > Int(score / 10) ? level : Int(score / 10)
        
        if level > 10 {
            level = 10
            informView.isHidden = false
            informLabel.isHidden = false
            informView.backgroundColor = UIColor(red: 0.01, green: 0.89, blue: 0.01, alpha: 0.5)
            informLabel.text = "GAME OVER\nCONGRATULATIONS!"
        }
        
        playerName.text = "lvl:\(level!)"
        
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
            mistakes.append("\(firstNum) \(operationLabel.text!) \(secondNum) = \(inputTextField.text!)")
            print("")
            print(player)
            print("")
            print(mistakes)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hideInfoView()
            }
            newTusk()
        }
    }
    
    @objc func doneButtonTapped() {
        checkResult()
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    
}

extension MainViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkResult()
        //        view.endEditing(true)
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        textField.resignFirstResponder()
//        return true
//    }
    
    
}

