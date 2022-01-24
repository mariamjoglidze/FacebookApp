//
//  HomeFeedScreenViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 24.01.22.
//

import UIKit
import FBSDKLoginKit

protocol HomeFeedScreenViewModelProtocol {
    var showLoading: (()->())? {get set}
    var feed: Feed {get set}
    var feedArray: [Feed]{get set}
    
    func fetchFeed(completion: @escaping ([Feed]) -> Void)
}

class HomeFeedScreenViewModel: HomeFeedScreenViewModelProtocol {
    var showLoading: (()->())?
    var feed = Feed(message: "", picture: "", likeCount: 0, commentCount: 0)
    var feedArray = [Feed]()
    
    func fetchFeed(completion: @escaping ([Feed]) -> Void){
        showLoading?()
        let requestMe = GraphRequest(graphPath: "me/feed",
                                     parameters: [Strings.fields : "id,message, picture.type(large)"],
                                     tokenString: Strings.token,
                                     version: nil,
                                     httpMethod: .get)
        
        
        requestMe.start(completion:{ connection, result, error in
    
            if let data: [String: Any] = result as? [String: Any] {
                print("---------------------")
                print(data)
                DispatchQueue.main.async
                {
                    if let array = data["data"] as? [[String: Any]] {
                        for getFeed in array {
                            self.feed.message = getFeed["message"] as? String ?? Strings.emptyString
                            self.feed.picture = getFeed["picture"] as? String ?? Strings.emptyString
                            self.feedArray.append(self.feed)
                        }
                        completion(self.feedArray)
                    }
                }
            }
        })
    }
}

