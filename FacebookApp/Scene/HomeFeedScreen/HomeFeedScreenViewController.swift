//
//  HomeFeedScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import FBSDKLoginKit
class HomeFeedScreenViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var homeFeedScreenViewModel: HomeFeedScreenViewModelProtocol!
    var feedArray: [Feed] = []{
            didSet {
                spinner.isHidden = true
                self.tableView.reloadData()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.registerNib(class: FeedCell.self)
        setupViewModel()
    }
    
    func setupViewModel(){
        homeFeedScreenViewModel = HomeFeedScreenViewModel()
        homeFeedScreenViewModel.fetchFeed { feed in
            self.feedArray.append(contentsOf: feed)
        }
        homeFeedScreenViewModel.showLoading = { self.spinner.startAnimating() }
    }
      
    
}


extension HomeFeedScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: FeedCell.self, for: indexPath)
        cell.configure(with: feedArray[indexPath.row])
        return cell
    }
}

