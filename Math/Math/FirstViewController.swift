//
//  FirstViewController.swift
//  Math
//
//  Created by vitasiy on 29/08/2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var regime: UISegmentedControl!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timerStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerStepper: UIStepper!
    @IBOutlet weak var levelLabel: UILabel!
    
    private var isTimerIn = false
    private var player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerStepper.value = 60
        timerStackView.isHidden = true
        
        nameTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let mainVC = segue.destination as? MainViewController else { return }
        
        if let lvl = Int(levelLabel.text ?? "0") {
            player.level = lvl
        }
        
        player.time = isTimerIn ? timerStepper.value : 5000.0
        
        if nameTextField.text != nil && nameTextField.text != "" {
            player.name = nameTextField.text!
        }
        
        player.regime = regime.selectedSegmentIndex
        
        mainVC.player = player
    }
    
    @IBAction func timerToggleSwitched(_ sender: UISwitch) {
        timerStackView.isHidden.toggle()
        isTimerIn = sender.isOn
    }
    
    
    @IBAction func timerValueChanged(_ sender: UIStepper) {
        
        let currentValue = sender.value
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .short
        
        let formattedString = formatter.string(from: TimeInterval(currentValue))
        timerLabel.text = formattedString
    }
    
    @IBAction func levelChanged(_ sender: UIStepper) {
        levelLabel.text = "\(Int(sender.value))"
    }
    
}

extension FirstViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
