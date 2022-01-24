//
//  ViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 17.01.22.
//

import UIKit


class SignInSceenViewController: UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!
    var signInScreenViewModel: SignInScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInBtn()
        setupViewModel()
    }
    
    func setupSignInBtn(){
        signInBtn.layer.borderWidth = 2.0
        signInBtn.layer.cornerRadius = 10.0
        signInBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    func setupViewModel(){
        signInScreenViewModel = SignInScreenViewModel()
        signInScreenViewModel.navigate = {
            self.navigationController?.popToRootViewController(animated: true)
    }
    }
    
    @IBAction func clickSignIn(_ sender: Any) {
        signInScreenViewModel.signIn()

    }
}

