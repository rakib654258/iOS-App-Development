//
//  customTableViewCell.swift
//  Country Api with Search
//
//  Created by macOS Mojave on 19/3/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
