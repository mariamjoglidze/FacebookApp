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
    func getNext(completion: @escaping ([Feed]) -> Void)
}

class HomeFeedScreenViewModel: HomeFeedScreenViewModelProtocol {
    var showLoading: (()->())?
    var feed = Feed(message: Strings.emptyString, picture: Strings.emptyString, likeCount: 0, commentCount: 0, source: Strings.emptyString)
    var feedArray = [Feed]()
    var nextLink : String?
    
    func fetchFeed(completion: @escaping ([Feed]) -> Void){
        showLoading?()
        let requestMe = GraphRequest(graphPath: "me/feed",
                                     parameters: [Strings.fields : "id,message, source, full_picture,feed.limit(10){to{id}}"],
                                     tokenString: Strings.token,
                                     version: nil,
                                     httpMethod: .get)
        
        requestMe.start(completion:{ connection, result, error in
            if let data: [String: Any] = result as? [String: Any] {
                print(data)
                DispatchQueue.main.async
                {
                    if let array = data["data"] as? [[String: Any]] {
                        
                        for getFeed in array {
                            self.feed.message = getFeed["message"] as? String ?? Strings.emptyString
                            self.feed.picture = getFeed["full_picture"] as? String ?? Strings.emptyString
                            self.feed.source = getFeed["source"] as? String ?? Strings.emptyString
                            self.feedArray.append(self.feed)
                        }
                        if let paging = data["paging"] as? [String : String] {
                            self.nextLink = paging["next"]
                        }
                        completion(self.feedArray)
                    }
                }
            }
        })
    }
    
    func getNext(completion: @escaping ([Feed]) -> Void) {
        var request: GraphRequest?
        let pageDict = Utility.dictionary(withQuery: self.nextLink ?? Strings.emptyString)
        request = GraphRequest.init(graphPath: "me/feed", parameters: pageDict, httpMethod: .get)
        request?.start(completion: { _, result, _ in
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async
                {
                    if let array = data["data"] as? [[String: Any]] {
                        var nextArray = [Feed]()
                        for getFeed in array {
                            self.feed.message = getFeed["message"] as? String ?? Strings.emptyString
                            self.feed.picture = getFeed["full_picture"] as? String ?? Strings.emptyString
                            self.feed.source = getFeed["source"] as? String ?? Strings.emptyString
                            nextArray.append(self.feed)
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
    
    
    
}

