//
//  FriendsListScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit
import RxSwift
import RxCocoa

class FriendsListScreenViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    var viewModel = FriendListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        bindTableView()
    }
    
    func bindTableView(){
        tableView.registerNib(class: FriendCell.self)
        viewModel.friendsArray.bind(to: tableView.rx.items(cellIdentifier: "FriendCell", cellType: FriendCell.self)) { (row,item,cell) in
            cell.friendNameLabel.text = item.name
            let url = URL(string: item.picture)
            if let data = try? Data(contentsOf: url!) {
                    cell.friendImage.image = UIImage(data: data)
                }             }.disposed(by: disposeBag)
        viewModel.fetchFriendList()

    }
}
