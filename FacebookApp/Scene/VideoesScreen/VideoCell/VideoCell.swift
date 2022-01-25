//
//  VideoCell.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 24.01.22.
//

import UIKit
import AVKit
import AVFoundation

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configure(with video: Video){
        videoTitleLabel.text = video.message
        let url = NSURL(string: video.source);
        let avPlayer = AVPlayer(url: url as! URL);
        playerView?.playerLayer.player = avPlayer;
        playerView?.player?.play()

    }
}
