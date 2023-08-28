//
//  MainViewController.swift
//  Math
//
//  Created by vitasiy on 27/08/2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var firstNumLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var secondNumLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var informView: UIView!
    @IBOutlet weak var informLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension MainViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

