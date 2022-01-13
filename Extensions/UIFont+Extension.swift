//
//  UIFont+Extension.swift
//  codeLab
//
//  Created by Alfie on 13/01/2022.
//

import Foundation
import UIKit

extension UIFont {
    
    static func SFMono(ofSize size: CGFloat) -> UIFont {
        return UIFont.monospacedSystemFont(ofSize: size, weight: .regular)
    }
    
    static func SF(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func NY(ofSize size: CGFloat) -> UIFont {
        let descriptor = UIFont.systemFont(ofSize: 34, weight: .regular).fontDescriptor
        if let serif = descriptor.withDesign(.serif) {
            return UIFont(descriptor: serif, size: size)
        } else {
            return UIFont(name: "Times", size: size)!
        }
    }
}
