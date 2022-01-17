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
        
        if let token = AccessToken.current,
           !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            
            request.start(completion:{ connection, result, error in
                print("\(result)")
            })
        } else {
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            
            view.addSubview(loginButton)
        }
        
        
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completion:{ connection, result, error in
            print("\(result)")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }
    
    
}

