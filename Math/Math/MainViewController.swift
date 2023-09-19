//
//  MainViewController.swift
//  Math
//
//  Created by vitasiy on 27/08/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var regimeView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var livesView: UIProgressView!
    
    @IBOutlet weak var firstNumLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var secondNumLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var informView: UIView!
    @IBOutlet weak var informLabel: UILabel!
    
    var player: Player!
    
    private var timer = 0.0
    
    private var firstNum = 0
    private var secondNum = 0
    
    private var counter = 0
    
    private let uD = StorageManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = player.time
        
        if timer != 5000.0 {
            navigationItem.title = transformTime(interval: timer)
            setTimer()
        } else {
            navigationItem.title = "♾️"
        }
        
        inputTextField.delegate = self
        
        setRegimeView()
        
        livesView.progress = Float(player.lives) / 10.0
        
        addButtonOnKeyBoard()
        
        playerName.text = "lvl:\(player.level)"
        newTusk()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.shownTasks = counter
        player.date = Date().formatted()
        uD.save(player: player)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let resultVC = segue.destination as? ResultsViewController else { return }
        
        player.score = player.score
        player.shownTasks = counter
        
        resultVC.player = player
        resultVC.completionHandler = { newPlayer in
            self.player = newPlayer
            self.player.score = self.player.score
            self.scoreLabel.text = "\(self.player.score)/\(self.counter)"
            self.livesView.progress = Float(self.player.lives) / 10.0
            self.setLivesLabel()
        }
    }
    
    private func transformTime(interval: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        
        guard let formattedString = formatter.string(from: TimeInterval(interval)) else { return "" }
        return formattedString
        
    }
    
    private func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
            self.timer -= 1.0
            self.navigationItem.title = self.transformTime(interval: self.timer)
            if self.timer <= 0 {
                t.invalidate()
                self.gameOver(isWin: true)
                
            }
        }
    }
    
    private func setRegimeView() {
        
        switch player.regime {
        case 0: regimeView.image = UIImage(systemName: "plus.forwardslash.minus")
        case 1: regimeView.image = UIImage(systemName: "multiply")
        case 2: regimeView.image = UIImage(systemName: "divide")
        default: regimeView.image = UIImage(systemName: "brain.head.profile")
        }
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
    
    private func gameOver(isWin: Bool) {
        informView.isHidden = false
        informLabel.isHidden = false
        
        if isWin {
            informView.backgroundColor = UIColor(red: 0.01, green: 0.89, blue: 0.01, alpha: 0.75)
            informLabel.font = informLabel.font.withSize(30)
            informLabel.text = "GAME OVER\nCONGRATULATIONS!\nYOUR SCORE: \(player.score)\n∑🎉🥳👏🎊"
            
        } else {
            informView.backgroundColor = UIColor(red: 0.9, green: 0.01, blue: 0.01, alpha: 0.75)
            informLabel.font = informLabel.font.withSize(30)
            informLabel.text = "GAME OVER\nYOU LOSE!\nYOUR SCORE: \(player.score)\n😩🌚🗿"
            
        }
        
    }
    
    private func plusMinus() {
        var a = 0
        var b = 0
        
        var range = 1...99
        
        switch player.level {
            
        case 0:
            range = 1...5
            a = Int.random(in: range)
            b = Int.random(in: range)
        case 1:
            range = 1...10
            a = Int.random(in: range)
            b = Int.random(in: range)
        case 2:
            range = 1...15
            a = Int.random(in: range)
            b = Int.random(in: range)
        case 3:
            range = 6...19
            a = Int.random(in: range)
            b = Int.random(in: range)
        case 4:
            range = 11...29
            a = Int.random(in: range)
            b = Int.random(in: range)
        case 5:
            range = 15...49
            a = Int.random(in: range)
            b = Int.random(in: range)
        case 6:
            range = 11...79
            a = Int.random(in: range)
            b = Int.random(in: range)
        case 7:
            a = 10 * Int.random(in: 2...9) + Int.random(in: 1...9)
            b = 10 * Int.random(in: 1...9) + Int.random(in: 1...9)
        case 8:
            a = 10 * Int.random(in: 3...9) + Int.random(in: 4...9)
            b = 10 * Int.random(in: 2...9) + Int.random(in: 2...9)
        case 9:
            a = 10 * Int.random(in: 1...9) + Int.random(in: 5...9)
            b = 10 * Int.random(in: 1...9) + Int.random(in: 5...9)
        default:
            a = 10 * Int.random(in: 5...9) + Int.random(in: 6...8)
            b = 10 * Int.random(in: 5...9) + Int.random(in: 6...9)
        }
        
        firstNum = max(a, b)
        secondNum = min(a, b)
        operationLabel.text = "\("+-".randomElement()!)"
    }
    
    private func multiply() {
        var a = 0
        var b = 0
        
        switch player.level {
            
        case 0:
            a = 1
            b = Int.random(in: 0...99)
        case 1:
            a = [1, 2].randomElement()!
            b = Int.random(in: 0...5)
        case 2:
            a = 2
            b = Int.random(in: 3...10)
        case 3:
            a = 2
            b = Int.random(in: 3...55)
        case 4:
            a = [2, 3].randomElement()!
            b = Int.random(in: 0...33)
        case 5:
            a = [1, 2, 3].randomElement()!
            b = Int.random(in: 3...50)
        case 6:
            a = 4
            b = Int.random(in: 2...11)
        case 7:
            a = [4, 5].randomElement()!
            b = Int.random(in: 2...15)
        case 8:
            a = Int.random(in: 1...5)
            b = Int.random(in: 2...22)
        case 9:
            a = 6
            b = Int.random(in: 0...11)
        default:
            a = Int.random(in: 0...10)
            b = Int.random(in: 0...10)
        }
        
        firstNum = max(a, b)
        secondNum = min(a, b)
        operationLabel.text = "*"
    }
    
    private func divide() {
        
        var a = 0
        var b = 0
        
        switch player.level {
            
        case 0:
            a = Int.random(in: 1...99)
            b = 1
        case 1:
            a = Int.random(in: 1...22) * 2
            b = 2
        case 2:
            a = 2
            b = Int.random(in: 1...45) * 2
        case 3:
            a = 3
            b = Int.random(in: 1...10) * 3
        case 4:
            a = 3
            b = Int.random(in: 1...20) * 3
        case 5:
            a = [2, 3].randomElement()!
            b = Int.random(in: 1...11) * a
        case 6:
            a = [2, 3, 4].randomElement()!
            b = Int.random(in: 1...11) * a
        case 7:
            a = [1, 2, 3, 4, 5].randomElement()!
            b = Int.random(in: 1...11) * a
        case 8:
            a = 5
            b = Int.random(in: 1...11) * a
        case 9:
            a = 6
            b = Int.random(in: 1...5) * a
        default:
            a = Int.random(in: 1...9)
            b = Int.random(in: 1...5) * a
        }
        
        firstNum = max(a, b)
        secondNum = min(a, b)
        operationLabel.text = "/"
    }
    
    
    private func newTusk() {
        
        player.level = player.level > Int(player.score / 10) ? player.level : Int(player.score / 10)
        
        if player.level > 10 {
            player.level = 10
            gameOver(isWin: true)
        }
        
        playerName.text = "lvl:\(player.level)"
        
        scoreLabel.text = "\(player.score)/\(counter)"
        counter += 1
        inputTextField.text = ""
        
        switch player.regime {
        case 0:
            plusMinus()
        case 1:
            multiply()
        case 2:
            divide()
        default:
            switch Int.random(in: 0...2) {
            case 0: plusMinus()
            case 1: multiply()
            default: divide()
            }
        }
        
        firstNumLabel.text = "\(firstNum)"
        secondNumLabel.text = "\(secondNum)"
        
    }
    
    private func operation() -> Int {
        
        var result = 0
        
        switch operationLabel.text {
        case "+": result = firstNum + secondNum
        case "-": result = firstNum - secondNum
        case "*": result = firstNum * secondNum
        case "/": result = firstNum / secondNum
        default:
            operationLabel.text = "+"
            result = firstNum + secondNum
        }
        
        return result
    }
    
    
    
    private func showInfoView(isRight: Bool) {
        informView.isHidden = false
        informLabel.isHidden = false
        if isRight {
            informView.backgroundColor = UIColor(red: 0.01, green: 0.89, blue: 0.01, alpha: 0.5)
            informLabel.font = informLabel.font.withSize(69)
            informLabel.text = "👍"
        } else {
            informView.backgroundColor = UIColor(red: 1, green: 0.01, blue: 0.01, alpha: 0.5)
            informLabel.font = informLabel.font.withSize(69)
            informLabel.text = "👊"
        }
        
    }
    
    private func hideInfoView() {
        informView.isHidden = true
        informLabel.isHidden = true
    }
    
    private func setLivesLabel() {
        var hearts = String(repeating: "❤️", count: player.lives / 2)
        
        if Double(player.lives) / 2 > Double(player.lives / 2) {
            hearts += "❤️‍🩹"
        }
        livesLabel.text = hearts
    }
    
    private func checkResult() {
        guard let inputedResult = inputTextField.text else { return }
        guard let inputedResult = Int(inputedResult) else { return }
        
        if inputedResult == operation() {
            showInfoView(isRight: true)
            player.score += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hideInfoView()
            }
            newTusk()
        } else {
            player.lives -= 1
            livesView.progress = Float(player.lives) / 10.0
            setLivesLabel()
            showInfoView(isRight: false)
            
            player.tasks.append(Task(firstNum: firstNum, secondNum: secondNum, operation: operationLabel.text!, inputedResult: inputedResult))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hideInfoView()
                if self.player.lives <= 0 {
                    self.gameOver(isWin: false)
                } else {
                    self.newTusk()
                }
            }
            
            
        }
    }
    
    private func backToTheBegining() {
        
        dismiss(animated: true)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateInitialViewController()
            delegate.window?.rootViewController = initialViewController
        }
        
    }
    
    @objc func doneButtonTapped() {
        if player.lives > 0 {
            checkResult()
        } else {
            backToTheBegining()
        }
        if timer <= 0 {
            backToTheBegining()
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if player.lives > 0 {
            checkResult()
        } else {
            backToTheBegining()
        }
        if timer <= 0 {
            backToTheBegining()
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if player.lives > 0 {
            checkResult()
        } else {
            backToTheBegining()
        }
        
        return true
    }
    
    
}

