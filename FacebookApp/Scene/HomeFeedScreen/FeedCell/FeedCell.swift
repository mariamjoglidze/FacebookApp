//
//  FeedCell.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    func configure(with feed: Feed){
        postDescriptionLabel.text = feed.message
        
        if  let url = URL(string: feed.picture),
            let data = try? Data(contentsOf: url) {
                self.postImage.image = UIImage(data: data)
            }
    }
    
}
