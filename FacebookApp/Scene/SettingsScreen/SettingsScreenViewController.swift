//
//  SettingsScreenViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

class SettingsScreenViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var viewModel: SettingsScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel(){
        viewModel = SettingsScreenViewModel()
        viewModel.getFacebookInfo()
        viewModel.imageData = { data in
            self.userImage.image = UIImage(data: data)
            self.userImage.layer.cornerRadius = self.userImage.bounds.width / 2
        }
        viewModel.userName = { name  in
            self.userNameLabel.text = name
        }
    }
}
