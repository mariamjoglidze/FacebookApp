//
//  FriendListScreenViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 21.01.22.
//

import UIKit
import FBSDKLoginKit
import RxSwift
import RxCocoa


class FriendListViewModel {
    var friend = Friend(name: Strings.emptyString, picture: Strings.emptyString)
    var friends = [Friend]()
    var friendsArray: BehaviorRelay<[Friend]> = BehaviorRelay(value: [])
    
    func fetchFriendList(){
         let requestMe = GraphRequest(graphPath: "me/friends",
                                      parameters: [Strings.fields : "id,name, picture.type(large)"],
                                      tokenString: Strings.tokenFriends,
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
                             self.friends.append(self.friend)
                             self.friendsArray.accept(self.friends)
                         }
                     }
                 }
             }
         })
     }
}
