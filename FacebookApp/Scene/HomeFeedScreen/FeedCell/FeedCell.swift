//
//  FeedCell.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.bounds.width / 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
