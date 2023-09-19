//
//  LeaderBoardTableViewController.swift
//  Math
//
//  Created by vitasiy on 07/09/2023.
//

import UIKit

class LeaderBoardTableViewController: UITableViewController {
    
    private let uD = StorageManager.shared
    
    private var players = [Player]()
    
    private let typesOfData = [
        "", "Score:", "Level:", "Lives:", "Time:", "Total tasks:"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = uD.fatchPlayers()
        
        let clearButton = UIBarButtonItem(title: "Clear",
                                          style: .done,
                                          target: self,
                                          action: #selector(clearUdMemory))
        navigationItem.rightBarButtonItem = clearButton
    }
    
    private func getImage(from regime: Int) -> UIImage? {
        switch regime {
        case 0: return UIImage(systemName: "plus.forwardslash.minus")
        case 1: return UIImage(systemName: "multiply")
        case 2: return UIImage(systemName: "divide")
        default: return UIImage(systemName: "brain.head.profile")
        }
    }
    
    private func transformTime(interval: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        
        guard let formattedString = formatter.string(from: TimeInterval(interval)) else { return "" }
        return formattedString
        
    }
    
    @objc func clearUdMemory() {
        showAlert(title: "‼️ Delete All ⁉️", message: "Are you sure you want to clear all of your results?")
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        players.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        players[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        typesOfData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaderBoardTableViewCell
        
        if indexPath.row != 0 {
            cell.mainLabel.text = typesOfData[indexPath.row]
            cell.gameTypeImage.tintColor = .clear
            cell.secondaryLabel.isHidden = false
            cell.deleteButton.isHidden = true
        } else {
            cell.mainLabel.text = players[indexPath.section].date
            cell.gameTypeImage.tintColor = .link
            cell.gameTypeImage.isHidden = false
            cell.secondaryLabel.isHidden = true
            cell.deleteButton.isHidden = false
            
        }
        
        switch indexPath.row {
        case 0:
            cell.gameTypeImage.image = getImage(from: players[indexPath.section].regime)
        case 1:
            cell.secondaryLabel.text = "\(players[indexPath.section].score)"
            cell.gameTypeImage.tintColor = .clear
        case 2:
            cell.secondaryLabel.text = "\(players[indexPath.section].level)"
        case 3:
            cell.secondaryLabel.text = "\(players[indexPath.section].lives)"
        case 4:
            let time = players[indexPath.section].time
            cell.secondaryLabel.text = time != 5000.0 ?
            "\(transformTime(interval: time))" :
            "∞"
        default:
            cell.secondaryLabel.text = "\(players[indexPath.section].shownTasks)"
        }
        
        cell.completionHandler = { didDelete in
            if didDelete {
                self.showAlert(title: "Delete", message: "Are you sure you want to delete this result?", all: false, index: indexPath.row)
            }
        }

        return cell
    }
}


extension LeaderBoardTableViewController {
    
    private func showAlert(title: String,
                           message: String,
                           all: Bool = true,
                           index: Int = 0) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "Yes",
            style: .default) { _ in
                if all {
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                        self.uD.deleteAll()
                        self.tableView.reloadData()
                    }
                } else {
                    self.uD.delete(at: index)
                    self.players = self.uD.fatchPlayers()
                    self.tableView.reloadData()
                }
            }
        
        let noAction = UIAlertAction(
            title: "No",
            style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
}

extension LeaderBoardTableViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        
    }
    
    
}
