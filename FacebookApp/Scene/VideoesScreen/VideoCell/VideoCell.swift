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
    @IBOutlet weak var videoSlider: UISlider!
    
    var viewModel = VideoCellViewModel()
    
    @IBAction func handleSliderChange(_ sender: Any) {
        let seconds : Int64 = Int64(videoSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        viewModel.playerLayer.player!.seek(to: targetTime)
        if viewModel.queuePlayer.rate == 0
        {
            viewModel.queuePlayer.play()
        }
    }
    
    func configureVideo(with video: Video){
        videoTitleLabel.text = video.message
        viewModel.videolink = NSURL(string: video.source) as URL?
    }
    func configureFeed(with video: Feed){
        videoTitleLabel.text = video.message
        viewModel.videolink = NSURL(string: video.source) as URL?
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewModel.playerLayer.frame = playerView.frame
        contentView.layer.addSublayer(viewModel.playerLayer)
        
    }
    func setupViewModel(){
        viewModel.videoSlider = { seconds in
            self.videoSlider.maximumValue = Float(seconds)
            self.videoSlider.isContinuous = true
        }
        viewModel.videoSliderValue = {time in
            self.videoSlider.value = Float(time);
        }
        viewModel.getvideoSliderValue = {
            Int64(self.videoSlider.value)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel.commonInit()
    }
    
}
