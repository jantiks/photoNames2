//
//  TableViewCell.swift
//  project12c
//
//  Created by Tigran on 12/19/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
