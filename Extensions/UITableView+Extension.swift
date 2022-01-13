//
//  UITableView+Extension.swift
//  codeLab
//
//  Created by Alfie on 13/01/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func selectInSection(_ indexPathToSelect: IndexPath) {
        for row in 0..<self.numberOfRows(inSection: indexPathToSelect.section) {
            let indexPath = IndexPath(row: row, section: indexPathToSelect.section)
            if indexPath.row == indexPathToSelect.row {
                self.cellForRow(at: indexPath)?.accessoryType = .checkmark
            } else {
                self.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
    }
    
    func selectInSection(row: Int, section: Int) {
        let indexPath = IndexPath(row: row, section: section)
        self.selectInSection(indexPath)
    }
    
}
