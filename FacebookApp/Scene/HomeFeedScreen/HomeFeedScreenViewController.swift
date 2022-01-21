//
//  HomeFeedScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

class HomeFeedScreenViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.registerNib(class: FeedCell.self)
        
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

