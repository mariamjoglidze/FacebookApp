//
//  FriendsListScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBAEMKit

class FriendsListScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var friend = Friend(name: "", picture: "")
    var friendsArray:[Friend] = []{
            didSet {
                self.tableView.reloadData()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.registerNib(class: FriendCell.self)
        fetchFriendList()
    }
    
    
    func fetchFriendList(){
        
        let requestMe = GraphRequest(graphPath: "me/friends",
                                     parameters: ["fields" : "id,name, picture.type(large)"],
                                     tokenString: "EAAHLlZCGjQWYBAHa2U8utqsUMgr8CWLQK2zgHYaKxmKFPr7VnGcPI4l1DQK2o9iGwZBokpNJvtDb79k3wKDxZBYfuG81PdIsR2sbFAyNZCMgyOctqtLxzMEST2pDmBMAfYSa4T7UfZCGDYfZC6G04cYzet9wUbAleFTO7QbZBCzZBJTsZBffLCkJmvM1jj0HitZAlXGFMDc2MTia49cgCXdF3F",
                                     version: nil,
                                     httpMethod: .get)
        
        
        requestMe.start(completion:{ connection, result, error in
            
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async
                {
                    if let array = data["data"] as? [[String: Any]]{
                        print(array)
                        for getfriend in array {
                            print(getfriend)
                            self.friend.name = getfriend["name"] as? String ?? "No name"
                            if let friendPictureData = getfriend["picture"] as? [String: Any] {
                                if let pictureData = friendPictureData["data"] as? [String: Any]{
                                    print("-------------imageurl \(pictureData["url"])")
                                    self.friend.picture = pictureData["url"] as? String ?? "No image"
                                }
                            }
                            self.friendsArray.append(self.friend)
                            print(self.friendsArray)
                        }
                    }
                }
            }
            
        })
    }
    
}


extension FriendsListScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: FriendCell.self, for: indexPath)
        cell.configure(with: friendsArray[indexPath.row])
        return cell
    }
}

