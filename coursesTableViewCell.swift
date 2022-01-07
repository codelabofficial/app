//
//  coursesTableViewCell.swift
//  codeLab
//
//  Created by Alfie on 06/01/2022.
//

import UIKit

class coursesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
