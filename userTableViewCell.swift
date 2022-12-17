//
//  userTableViewCell.swift
//  companyMachineTask
//
//  Created by Digvijay Nikam on 17/12/22.
//

import UIKit

class userTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fristNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
