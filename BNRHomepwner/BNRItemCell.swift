//
//  BNRItemCell.swift
//  BNRHomepwner
//
//  Created by sid on 5/30/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRItemCell: UITableViewCell {

    @IBOutlet weak var tumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var actionBlock:(() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showImage(sender: UIButton) {
        if((actionBlock) != nil){
            actionBlock!()
        }
    }
}
