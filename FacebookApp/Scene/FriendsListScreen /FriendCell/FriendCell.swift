//
//  FriendCell.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var mutualFriendLabel: UILabel!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendImage.layer.cornerRadius = friendImage.bounds.width / 2
    }
    
    func configure(with friend: Friend){
        friendNameLabel.text = friend.name
        let url = URL(string: friend.picture as! String ?? "")
        if let data = try? Data(contentsOf: url!) {
                self.friendImage.image = UIImage(data: data)
            }
}
}
