//
//  VideoCellViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 31.01.22.
//

import UIKit
import AVKit
import AVFoundation

class VideoCellViewModel {
    
    var isPlaying: Bool = false
    var queuePlayer = AVQueuePlayer()
    var playerLayer = AVPlayerLayer()
    var looperPlayer: AVPlayerLooper?
    
    var videoSlider: ((Float64)->())?
    var videoSliderValue:((Float64)->())?
    var getvideoSliderValue:(()->(Int64))?
    
    public var videolink: URL? = nil {
        didSet {
            guard let link = videolink, oldValue != link else { return }
            loadVideoUsingURL(link)
        }
    }
    
    func startPlaying() {
        queuePlayer.play()
        isPlaying = true
    }
    
    func stopPlaying() {
        queuePlayer.pause()
        isPlaying = false
    }
    
    func commonInit() {
        queuePlayer.volume = 0.0
        queuePlayer.actionAtItemEnd = .none
        playerLayer.videoGravity = .resizeAspect
        playerLayer.cornerRadius = 5.0
        playerLayer.masksToBounds = true
        playerLayer.player = queuePlayer
    }
    
    func loadVideoUsingURL(_ url: URL) {
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
                    self.videoSlider?(seconds)
                    self.queuePlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
                        if self.queuePlayer.currentItem?.status == .readyToPlay {
                            let time : Float64 = CMTimeGetSeconds((self.queuePlayer.currentTime()));
                            self.videoSliderValue?(time)
                        }
                    }
                }
            }
        }
    }
}
