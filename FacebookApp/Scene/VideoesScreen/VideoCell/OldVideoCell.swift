//
//  VideoCell.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

class OldVideoCell: UITableViewCell {

    @IBOutlet weak var videoDescriptionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func configure(with video: Video){
        videoDescriptionLabel.text = video.message
        let url = URL(string: video.picture as! String ?? "")
        if let data = try? Data(contentsOf: url!) {
                self.videoImage.image = UIImage(data: data)
            }
     }
}
