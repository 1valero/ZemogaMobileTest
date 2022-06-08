//
//  CommentsTableViewCell.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 6/06/22.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblComment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
