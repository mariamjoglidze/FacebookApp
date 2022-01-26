//
//  HomeFeedScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import FBSDKLoginKit
import AVKit
import AVFoundation

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
        setupTableView()
        setupViewModel()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(class: VideoCell.self)
        tableView.registerNib(class: FeedCell.self)
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
        if feedArray[indexPath.row].source == "" {
            let cell = tableView.deque(class: FeedCell.self, for: indexPath)
            cell.configure(with: feedArray[indexPath.row])
            return cell
        } else {
            let cell = tableView.deque(class: VideoCell.self, for: indexPath)
            cell.configureFeed(with: feedArray[indexPath.row])
            return cell
        }
    }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            let cells = tableView.visibleCells.compactMap({ $0 as? VideoCell })
            cells.forEach { videoCell in
                if videoCell.isPlaying {
                    videoCell.stopPlaying()
                }
            }
        }
    }
    
    extension HomeFeedScreenViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let cell = tableView.cellForRow(at: indexPath) as? VideoCell {
                if cell.isPlaying {
                    cell.stopPlaying()
                } else {
                    cell.startPlaying()
                }
            }
        }
    }
