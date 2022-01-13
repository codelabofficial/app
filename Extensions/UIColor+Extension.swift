//
//  UIColor+Extension.swift
//  codeLab
//
//  Created by Alfie on 13/01/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(_ hex: Int) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF)/255,
            green: CGFloat((hex >> 8) & 0xFF)/255,
            blue: CGFloat(hex & 0xFF)/255,
            alpha: 1.0
        )
    }
    
    convenience init(_ hex: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF)/255,
            green: CGFloat((hex >> 8) & 0xFF)/255,
            blue: CGFloat(hex & 0xFF)/255,
            alpha: alpha
        )
    }
    
}
