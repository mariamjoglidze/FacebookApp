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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var logOutBtn: UIButton!
    
    var viewModel: SettingsScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupButton()
    }
    
    func setupViewModel(){
        viewModel = SettingsScreenViewModel()
        viewModel.getFacebookInfo()
        viewModel.showLoading = { self.spinner.startAnimating() }
        viewModel.hideLoading = {
            self.spinner.isHidden = true
        }
        viewModel.imageData = { data in
            self.userImage.image = UIImage(data: data)
            self.userImage.layer.cornerRadius = self.userImage.bounds.width / 2
        }
        viewModel.userName = { name  in
            self.userNameLabel.text = name
        }
        viewModel.navigate = {
            self.navigationController?.popToRootViewController(animated: true)

        }
    }
    
    func setupButton(){
        logOutBtn.layer.borderWidth = 2.0
        logOutBtn.layer.borderColor = UIColor.lightGray.cgColor
        logOutBtn.layer.cornerRadius = 10.0
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        viewModel.logOut()
    }

}
