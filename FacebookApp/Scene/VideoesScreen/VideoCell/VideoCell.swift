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
    //////////////////
    public var isPlaying: Bool = false
    private var queuePlayer = AVQueuePlayer()
    private var playerLayer = AVPlayerLayer()
    private var looperPlayer: AVPlayerLooper?
    ////////////////
    ///
    public var videolink: URL? = nil {
        didSet {
            guard let link = videolink, oldValue != link else { return }
            loadVideoUsingURL(link)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            }
    
    
    func configure(with video: Video){
        videoTitleLabel.text = video.message
        let url = NSURL(string: video.source)
        let avPlayer = AVPlayer(url: url as! URL)
        playerView?.playerLayer.player = avPlayer
        //        playerView?.player?.play()
        
    }
    
    func play(with video: Video){
        //        let url = NSURL(string: video.source)
        //        let avPlayer = AVPlayer(url: url as! URL)
        //        playerView?.playerLayer.player = avPlayer
        playerView?.player?.play()
    }
    
    
    public func startPlaying() {
        queuePlayer.play()
        isPlaying = true
    }
    
    public func stopPlaying() {
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
        playerLayer.name = "videoLoopLayer"
        playerLayer.cornerRadius = 5.0
        playerLayer.masksToBounds = true
        contentView.layer.addSublayer(playerLayer)
        playerLayer.player = queuePlayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// Resize video layer based on new frame
        playerLayer.frame = playerView.frame
//        playerLayer.frame = CGRect(origin: .zero, size: CGSize(width: frame.width, height: frame.width))
    }
    
    private func loadVideoUsingURL(_ url: URL) {
        /// Load asset in background thread to avoid lagging
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url)
            /// Load needed values asynchronously
            asset.loadValuesAsynchronously(forKeys: ["duration", "playable"]) {
                /// UI actions should executed on the main thread
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    let item = AVPlayerItem(asset: asset)
                    if self.queuePlayer.currentItem != item {
                        self.queuePlayer.replaceCurrentItem(with: item)
                        self.looperPlayer = AVPlayerLooper(player: self.queuePlayer, templateItem: item)
                    }
                }
            }
        }
    }
}
