//
//  FriendListScreenViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 21.01.22.
//

import UIKit
import FBSDKLoginKit

protocol FriendListScreenViewModelProtocol {
    var friend: Friend {get set}
    var friendsArray: [Friend] {get set}
    var showLoading: (()->())? {get set}

    func fetchFriendList(completion: @escaping ([Friend]) -> Void)
}

class FriendListScreenViewModel: FriendListScreenViewModelProtocol {
    var friend = Friend(name: "", picture: "")
    var friendsArray: [Friend] = []
    var showLoading: (()->())?

    func fetchFriendList(completion: @escaping ([Friend]) -> Void){
        showLoading?()
        let requestMe = GraphRequest(graphPath: "me/friends",
                                     parameters: [Strings.fields : "id,name, picture.type(large)"],
                                     tokenString: Strings.token,
                                     version: nil,
                                     httpMethod: .get)
        
        requestMe.start(completion:{ connection, result, error in
            
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async
                {
                    if let array = data["data"] as? [[String: Any]]{
                        for getfriend in array {
                            self.friend.name = getfriend["name"] as? String ?? Strings.emptyString
                            if let friendPictureData = getfriend["picture"] as? [String: Any] {
                                if let pictureData = friendPictureData["data"] as? [String: Any]{
                                    self.friend.picture = pictureData["url"] as? String ?? Strings.emptyString
                                }
                            }
                            self.friendsArray.append(self.friend)
                        }
                        completion(self.friendsArray)
                    }
                }
            }
        })
    }
}
