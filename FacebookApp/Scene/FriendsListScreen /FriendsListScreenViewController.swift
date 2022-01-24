//
//  FriendsListScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit


class FriendsListScreenViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var friendsArray:[Friend] = []{
            didSet {
                spinner.isHidden = true
                self.tableView.reloadData()
            }
        }
    
    var viewModel: FriendListScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.registerNib(class: FriendCell.self)
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = FriendListScreenViewModel()
        viewModel.fetchFriendList { friends in
            self.friendsArray.append(contentsOf: friends)
        }
        viewModel.showLoading = { self.spinner.startAnimating() }

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

