//
//  ResultsViewController.swift
//  Math
//
//  Created by vitasiy on 29/08/2023.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    
    var player: Player!
    var completionHandler: ((Player) ->())!
    
    
    private var isSolved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myNavigationBar.topItem?.title = "Mistakes List"
        
        presentationController?.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = player.tasks[indexPath.row].getStringTask()
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(player.name), Lvl: \(player.level), Score: \(player.score), Total tasks: \(player.shownTasks)"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertWithTextField(
            title: "Take your time",
            message: player.tasks[indexPath.row].getStringTask(),
            index: indexPath
        )
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ResultsViewController {
    
    private func showAlertWithTextField(title: String,
                                        message: String,
                                        index: IndexPath) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
        }
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { _ in
                
                let text = alert.textFields?.first?.text
                let result = self.player.tasks[index.row].result()
                
                if text == "\(result)" {
                    UISelectionFeedbackGenerator().selectionChanged()
                    self.isSolved = true
                } else {
                    self.isSolved = false
                }
                
                if self.isSolved {
                    self.player.tasks.remove(at: index.row)
                    self.tableView.deleteRows(at: [index], with: .right)
                    self.tableView.reloadData()
                    self.player.score += 1
                    self.player.lives += 1
                }
            }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

extension ResultsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        completionHandler(player)
    }
}
