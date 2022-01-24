//
//  HomeFeedScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import FBSDKLoginKit
class HomeFeedScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.registerNib(class: FeedCell.self)
        fetchHomeFeed()
    }
    func fetchHomeFeed(){
        let requestMe = GraphRequest(graphPath: "me/feed",
                                     parameters: [Strings.fields : "id,name, picture.type(large)"],
                                     tokenString: Strings.token,
                                     version: nil,
                                     httpMethod: .get)
        
        requestMe.start(completion:{ connection, result, error in
            print("-------------------------------------------------")
            print(result)
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async
                {
                   
                }
            }
        })
    }
    
}


extension HomeFeedScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: FeedCell.self, for: indexPath)
        
        return cell
    }
}

