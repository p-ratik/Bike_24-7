//
//  MenuTableViewCell.swift
//  Bike_24*7
//
//  Created by Capgemini-DA161 on 12/13/22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
