//
//  ViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 17.01.22.
//

import UIKit
import FBSDKLoginKit


class SignInSceneViewController: UIViewController, LoginButtonDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
        }
        
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = "EAAHLlZCGjQWYBAHa2U8utqsUMgr8CWLQK2zgHYaKxmKFPr7VnGcPI4l1DQK2o9iGwZBokpNJvtDb79k3wKDxZBYfuG81PdIsR2sbFAyNZCMgyOctqtLxzMEST2pDmBMAfYSa4T7UfZCGDYfZC6G04cYzet9wUbAleFTO7QbZBCzZBJTsZBffLCkJmvM1jj0HitZAlXGFMDc2MTia49cgCXdF3F"
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completion:{ connection, result, error in
            let sb = UIStoryboard(name: "TabBar", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TabBarViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }
    
}

