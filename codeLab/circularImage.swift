//
//  circularImage.swift
//  
//
//  Created by Alfie on 03/01/2022.
//

import UIKit

@IBDesignable
class circularImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
