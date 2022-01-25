//
//  VideoesScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import FBSDKLoginKit
import AVKit
import AVFoundation

class VideoesScreenViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var videoScreenViewModel: VideoScreenViewModelProtocol!
    var videoArray: [Video] = []{
        didSet {
            spinner.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(class: OldVideoCell.self)
        tableView.registerNib(class: VideoCell.self)
        setupViewModel()
    }
    func setupViewModel(){
        videoScreenViewModel = VideoScreenViewModel()
        videoScreenViewModel.fetchVideo{ video in
            self.videoArray.append(contentsOf: video)
        }
        videoScreenViewModel.showLoading = { self.spinner.startAnimating() }
        videoScreenViewModel.presentVideo = { playerController in
            self.present(playerController, animated: true, completion: nil)
        }
    }
}


extension VideoesScreenViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: VideoCell.self, for: indexPath)
        cell.configure(with: videoArray[indexPath.row])
        return cell
    }
    
}

extension VideoesScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.deque(class: VideoCell.self, for: indexPath)
//        cell.playerView?.player?.play()

        //        videoScreenViewModel.playVideo(videoURL: videoArray[indexPath.row].source)
    }
}
