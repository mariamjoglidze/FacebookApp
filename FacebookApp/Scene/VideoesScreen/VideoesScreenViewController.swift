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
        setupTableView()
        setupViewModel()
    }
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(class: VideoCell.self)
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
        cell.videoTitleLabel.text = videoArray[indexPath.row].message
        cell.videolink = NSURL(string: videoArray[indexPath.row].source) as URL?
        return cell
    }
    
    
//        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            guard let videoCell = cell as? VideoCell else { return }
//    //        videoCell.startPlaying()
//        }
//
//        func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//            guard let videoCell = cell as? VideoCell else { return }
//            videoCell.stopPlaying()
//        }
//
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let cells = tableView.visibleCells.compactMap({ $0 as? VideoCell })
        cells.forEach { videoCell in
            if videoCell.isPlaying {
                videoCell.stopPlaying()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        guard !decelerate else { return }
//        let cells = tableView.visibleCells.compactMap({ $0 as? VideoCell })
//        cells.forEach  { videoCell in
//            if !videoCell.isPlaying  {
//                videoCell.startPlaying()
//            }
//        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let cells = tableView.visibleCells.compactMap({ $0 as? VideoCell })
//        cells.forEach { videoCell in
//            if !videoCell.isPlaying  {
//                videoCell.startPlaying()
//            }
//        }
    }
    
}

extension VideoesScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? VideoCell {
            if cell.isPlaying {
                cell.stopPlaying()
            } else {
                cell.startPlaying()
            }
        }
        
        //        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
