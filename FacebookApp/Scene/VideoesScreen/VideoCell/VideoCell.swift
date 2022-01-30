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
    
    var isPlaying: Bool = false
    private var queuePlayer = AVQueuePlayer()
    private var playerLayer = AVPlayerLayer()
    private var looperPlayer: AVPlayerLooper?
    
    public var videolink: URL? = nil {
        didSet {
            guard let link = videolink, oldValue != link else { return }
            loadVideoUsingURL(link)
        }
    }
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .gray
        slider.maximumTrackTintColor = .black
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        print(videoSlider.value)
        let seconds : Int64 = Int64(videoSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        playerLayer.player!.seek(to: targetTime)
        
        if playerLayer.player!.rate == 0
        {
            playerLayer.player?.play()
        }
    }
    
    func configureVideo(with video: Video){
        videoTitleLabel.text = video.message
        videolink = NSURL(string: video.source) as URL?
    }
    func configureFeed(with video: Feed){
        videoTitleLabel.text = video.message
        videolink = NSURL(string: video.source) as URL?
    }
    
    func startPlaying() {
        queuePlayer.play()
        isPlaying = true
    }
    
    func stopPlaying() {
        queuePlayer.pause()
        isPlaying = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        queuePlayer.volume = 0.0
        queuePlayer.actionAtItemEnd = .none
        playerLayer.videoGravity = .resizeAspect
//        playerLayer.name = "videoLoopLayer"
        playerLayer.cornerRadius = 5.0
        playerLayer.masksToBounds = true
        contentView.layer.addSublayer(playerLayer)
        playerLayer.player = queuePlayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(videoSlider)
        videoSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        videoSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true
        playerLayer.frame = playerView.frame
    }
    
    private func loadVideoUsingURL(_ url: URL) {
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url)
            asset.loadValuesAsynchronously(forKeys: ["duration", "playable"]) {
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    let item = AVPlayerItem(asset: asset)
                    if self.queuePlayer.currentItem != item {
                        self.queuePlayer.replaceCurrentItem(with: item)
                        self.looperPlayer = AVPlayerLooper(player: self.queuePlayer, templateItem: item)
                    }
                    let duration : CMTime = item.asset.duration
                    let seconds : Float64 = CMTimeGetSeconds(duration)
                    self.videoSlider.maximumValue = Float(seconds)
                    self.videoSlider.isContinuous = true
                    
                    self.playerLayer.player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
                        if self.playerLayer.player?.currentItem?.status == .readyToPlay {
                            let time : Float64 = CMTimeGetSeconds((self.playerLayer.player!.currentTime()));
                            self.videoSlider.value = Float ( time );
                        }
                    }
                }
            }
        }
    }
}
