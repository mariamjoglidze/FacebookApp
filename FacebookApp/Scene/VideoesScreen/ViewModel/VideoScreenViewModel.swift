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
}

class VideoScreenViewModel: VideoScreenViewModelProtocol {
    var video = Video(message: "", picture: "", source: "")
    var videoArray = [Video]()
    var showLoading: (()->())?
    var presentVideo: ((AVPlayerViewController)->())?

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
}
