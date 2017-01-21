//
//  PillTableViewCell.swift
//  SimpillPage
//
//  Created by Mason Swofford on 4/19/16.
//  Copyright © 2016 Mason Swofford. All rights reserved.
//

import UIKit

class PillTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dispensionLabel: UILabel!
    @IBOutlet weak var pillsRemainingLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
