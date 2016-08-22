//
//  SearchButton.swift
//  USCongress
//
//  Created by Julius D. Higiro on 8/10/16.
//  Copyright © 2016 Julius D. Higiro. All rights reserved.
//

import UIKit

class SearchButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        
        self.setTitle("STAY INFORMED", forState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        self.layer.cornerRadius = cornerRadius
    
    }

}
