//
//  FirstViewController.swift
//  Math
//
//  Created by vitasiy on 29/08/2023.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let mainVC = segue.destination as? MainViewController else { return }
        
        mainVC.level = Int(levelLabel.text ?? "0")
        mainVC.pName = nameTextField.text ?? "Player"
        
    }
    
    @IBAction func levelChanged(_ sender: UIStepper) {
        
        levelLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
    
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
