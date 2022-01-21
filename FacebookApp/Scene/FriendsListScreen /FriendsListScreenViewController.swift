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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.registerNib(class: FriendCell.self)
        fetchFriendList()
    }
    
    func fetchFriendList(){
        //        GraphRequestConnection.
        //        startForMyFriendsWithCompletionHandler({ (connection, result, error: NSError!) -> Void in
        //            if error == nil {
        //                var friendObjects = result["data"] as [NSDictionary]
        //                for friendObject in friendObjects {
        //                    println(friendObject["id"] as NSString)
        //                }
        //                println("\(friendObjects.count)")
        //            } else {
        //                println("Error requesting friends list form facebook")
        //                println("\(error)")
        //            }
        //        })
        //    }
        let requestMe = GraphRequest(graphPath: "me/friends",
                                     parameters: ["fields" : "id,name, picture.type(large)"],
                                     tokenString: "EAAHLlZCGjQWYBABI5LJVcuQb7ReGSBDt9bYPOqgt08Fb4AOlb3TASZALZB8iZAOZA71WoLU6ax9y7VrE4GjuiGNKyfEpiTC5t9vVlG2EoNsIN4glWc1BqYUGRSBp4huZAMZCmu4MSrv64JDhsybcptEtvM0A2cjYqw7fif7ydWHWWIuVlu6NNzmr6gZBRwZAUZBV6BG2xRXTpUDnoueHWkbwy3",
                                     version: nil,
                                     httpMethod: .get)
        
        
        requestMe.start(completion:{ connection, result, error in
            print(result)
            
            
     
                        })
    }
    
}


extension FriendsListScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: FriendCell.self, for: indexPath)
        
        return cell
    }
}

