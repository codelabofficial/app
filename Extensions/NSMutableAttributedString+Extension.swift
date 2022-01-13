//
//  NSMutableAttributedString+Extension.swift
//  
//
//  Created by Alfie on 13/01/2022.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func highlight(pattern: String, caseSensitive: Bool = false) {
        let searchResults = self.string.rangesOfPattern(
            pattern,
            caseSensitive: caseSensitive)

        for range in searchResults {
            self.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: range)
            self.addAttribute(.foregroundColor, value: UIColor.darkText, range: range)
        }
    }
    
}
