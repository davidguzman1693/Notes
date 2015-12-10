//
//  CustomTableViewCell.swift
//  MyNotes
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
