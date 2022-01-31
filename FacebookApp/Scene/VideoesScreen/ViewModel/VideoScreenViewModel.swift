//
//  VideoScreenViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 24.01.22.
//

import UIKit
import FBSDKLoginKit
import AVKit
import AVFoundation

protocol VideoScreenViewModelProtocol {
    var video: Video {get set}
    var videoArray: [Video] {get set}
    var showLoading: (()->())? {get set}
    var presentVideo: ((AVPlayerViewController)->())? {get set}
    
    func fetchVideo(completion: @escaping ([Video]) -> Void)
    func getNext(completion: @escaping ([Video]) -> Void)

}

class VideoScreenViewModel: VideoScreenViewModelProtocol {
    var video = Video(message: Strings.emptyString, picture: Strings.emptyString, source: Strings.emptyString)
    var videoArray = [Video]()
    var showLoading: (()->())?
    var presentVideo: ((AVPlayerViewController)->())?
    var nextLink : String?

    func fetchVideo(completion: @escaping ([Video]) -> Void) {
        showLoading?()
        let requestMe = GraphRequest(graphPath: "me/posts",
                                     parameters: [Strings.fields : "id,message, source, picture.type(large)"],
                                     tokenString: Strings.token,
                                     version: nil,
                                     httpMethod: .get)
        
        requestMe.start(completion:{ connection, result, error in
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async
                {
                    if let array = data["data"] as? [[String: Any]] {
                        for getVideo in array {
                            self.video.message = getVideo["message"] as? String ?? Strings.emptyString
                            self.video.source = getVideo["source"] as? String ?? Strings.emptyString
                            self.video.picture = getVideo["picture"] as? String ?? Strings.emptyString
                            if self.video.source != ""{
                                self.videoArray.append(self.video)
                            }
                        }
                        completion(self.videoArray)
                    }
                }
            }
        })
    }
    
    func getNext(completion: @escaping ([Video]) -> Void) {
        var request: GraphRequest?
        let pageDict = Utility.dictionary(withQuery: self.nextLink ?? Strings.emptyString)
        request = GraphRequest.init(graphPath: "me/feed", parameters: pageDict, httpMethod: .get)
        request?.start(completion: { _, result, _ in
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async
                {
                    if let array = data["data"] as? [[String: Any]] {
                        var nextArray = [Video]()
                        for getVideo in array {
                            self.video.message = getVideo["message"] as? String ?? Strings.emptyString
                            self.video.picture = getVideo["picture"] as? String ?? Strings.emptyString
                            self.video.source = getVideo["source"] as? String ?? Strings.emptyString
                            nextArray.append(self.video)
                        }
                        if let paging = data["paging"] as? [String : String] {
                            self.nextLink = paging["next"]
                        }
                        completion(nextArray)
                    }
                }
            }
        })
    }

//    var isPlaying: Bool = false
//    private var queuePlayer = AVQueuePlayer()
//    private var playerLayer = AVPlayerLayer()
//    private var looperPlayer: AVPlayerLooper?
//
//    var videoSlider: ((Float64)->())?
//    var videoSliderValue:((Float64)->())?
//
//    public var videolink: URL? = nil {
//        didSet {
//            guard let link = videolink, oldValue != link else { return }
//            loadVideoUsingURL(link)
//        }
//    }
//    func loadVideoUsingURL(_ url: URL) {
//        DispatchQueue.global(qos: .background).async {
//            let asset = AVURLAsset(url: url)
//            asset.loadValuesAsynchronously(forKeys: ["duration", "playable"]) {
//                DispatchQueue.main.async { [weak self] in
//                    guard let `self` = self else { return }
//                    let item = AVPlayerItem(asset: asset)
//                    if self.queuePlayer.currentItem != item {
//                        self.queuePlayer.replaceCurrentItem(with: item)
//                        self.looperPlayer = AVPlayerLooper(player: self.queuePlayer, templateItem: item)
//                    }
//                    let duration : CMTime = item.asset.duration
//                    let seconds : Float64 = CMTimeGetSeconds(duration)
//                    self.videoSlider?(seconds)
////                    self.videoSlider.maximumValue = Float(seconds)
////                    self.videoSlider.isContinuous = true
//
//                    self.queuePlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
//                        if self.queuePlayer.currentItem?.status == .readyToPlay {
//                            let time : Float64 = CMTimeGetSeconds((self.queuePlayer.currentTime()));
//                            self.videoSliderValue?(time)
////                            self.videoSlider.value = Float ( time );
//                        }
//                    }
//                }
//            }
//        }
//    }
//}


}
