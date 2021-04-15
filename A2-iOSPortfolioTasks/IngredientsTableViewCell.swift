//
//  IngredientsTableViewCell.swift
//  A2-iOSPortfolioTasks
//
//  Created by Zigeng Feng on 4/10/21.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var meaurementLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
