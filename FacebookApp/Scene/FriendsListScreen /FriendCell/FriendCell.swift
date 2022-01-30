//
//  FriendCell.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import RxCocoa
import RxSwift

class FriendCell: UITableViewCell {

    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendImage.layer.cornerRadius = friendImage.bounds.width / 2
    }
}
