//
//  DetailTableViewCell.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 17/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import UIKit

var detailCellIdentifier: String = "detailCell"

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
