//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 6/06/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgviewArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
