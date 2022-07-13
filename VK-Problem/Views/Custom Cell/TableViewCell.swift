//
//  TableViewCell.swift
//  VK-Problem
//
//  Created by Fed on 13.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var nameServiceLabel: UILabel!
    @IBOutlet weak var descriptionServiceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
