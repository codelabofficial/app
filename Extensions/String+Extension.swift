//
//  String+Extension.swift
//  codeLab
//
//  Created by Alfie on 13/01/2022.
//

import Foundation

extension String {
    
    func rangesOfPattern(_ pattern: String, caseSensitive: Bool = false) -> [NSRange] {
        guard pattern != "" else { return [NSRange]() }
        let range = NSRange(location: 0, length: self.utf16.count)
        var regex = try! NSRegularExpression(pattern: pattern)
        if !caseSensitive {
            regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        }

        let matches = regex.matches(in: self, options: [], range: range)

        var result = [NSRange]()
        for match in matches {
            result.append(match.range)
        }
        return result
    }
    
    func rangesOfPatterns(_ patterns: [String], caseSensitive: Bool = false) -> [NSRange] {
        var result = [NSRange]()
        for pattern in patterns {
            let ranges = self.rangesOfPattern(pattern, caseSensitive: caseSensitive)
            for range in ranges {
                result.append(range)
            }
        }
        return result
    }
}
