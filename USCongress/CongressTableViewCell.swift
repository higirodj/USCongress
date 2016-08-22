//
//  CongressTableViewCell.swift
//  USCongress
//
//  Created by Julius D. Higiro on 8/15/16.
//  Copyright © 2016 Julius D. Higiro. All rights reserved.
//

import UIKit

class CongressTableViewCell: UITableViewCell {

    @IBOutlet weak var backGroundCardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var termEndLabel: UILabel!
    @IBOutlet weak var termStartLabel: UILabel!
    @IBOutlet weak var officialPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        officialPicture.layer.masksToBounds = true
        officialPicture.layer.borderColor = UIColor.whiteColor().CGColor
        officialPicture.layer.borderWidth = 1.0
        
        
        backGroundCardView.backgroundColor = UIColor.whiteColor()
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        backGroundCardView.layer.cornerRadius = 3.0
        backGroundCardView.layer.masksToBounds = false
        
        backGroundCardView.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        
        backGroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backGroundCardView.layer.shadowOpacity = 0.8
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
