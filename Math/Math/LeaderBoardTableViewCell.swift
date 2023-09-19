//
//  LeaderBoardTableViewCell.swift
//  Math
//
//  Created by vitasiy on 15/09/2023.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var gameTypeImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var completionHandler: ((Bool) ->())!
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        completionHandler(true)
    }
    

    
    
}
