//
//  TableViewCell.swift
//  TableViewHP
//
//  Created by Gianmarco Giretti on 06.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func commonInit(_ imageName: String, title: String, sub: String) {
        logoImage.image = UIImage(named: imageName)
        titleLabel.text = title
        subLabel.text = sub
    }
    
}
