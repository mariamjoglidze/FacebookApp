//
//  ViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 17.01.22.
//

import UIKit
import FBSDKLoginKit


class SignInSceneViewController: UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSignInBtn()
    }
    
    
    func setupSignInBtn(){
        signInBtn.layer.borderWidth = 2
        signInBtn.layer.cornerRadius = 10
        signInBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func clickSignIn(_ sender: Any) {
        let token = "EAAHLlZCGjQWYBAHa2U8utqsUMgr8CWLQK2zgHYaKxmKFPr7VnGcPI4l1DQK2o9iGwZBokpNJvtDb79k3wKDxZBYfuG81PdIsR2sbFAyNZCMgyOctqtLxzMEST2pDmBMAfYSa4T7UfZCGDYfZC6G04cYzet9wUbAleFTO7QbZBCzZBJTsZBffLCkJmvM1jj0HitZAlXGFMDc2MTia49cgCXdF3F"
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completion:{ connection, result, error in
            let loginManager = LoginManager()
            let sb = UIStoryboard(name: "TabBar", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TabBarViewController")
            vc.modalPresentationStyle = .fullScreen
            loginManager.logIn(permissions: ["public_profile", "email"], viewController: vc) { result in
            
                self.present(vc, animated: true, completion: nil)
            }
        })
        
        
    }
    
}

