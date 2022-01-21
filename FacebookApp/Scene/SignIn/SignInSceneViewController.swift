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
        
//        if let token = AccessToken.current,
//           !token.isExpired {
//            let token = token.tokenString
//            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
//                                                     parameters: ["fields": "email, name"],
//                                                     tokenString: token,
//                                                     version: nil,
//                                                     httpMethod: .get)
//
//            request.start(completion:{ connection, result, error in
//                print("\(result)")
//            })
//        } else {
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            
            view.addSubview(loginButton)
        }
        
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = "EAAHLlZCGjQWYBABI5LJVcuQb7ReGSBDt9bYPOqgt08Fb4AOlb3TASZALZB8iZAOZA71WoLU6ax9y7VrE4GjuiGNKyfEpiTC5t9vVlG2EoNsIN4glWc1BqYUGRSBp4huZAMZCmu4MSrv64JDhsybcptEtvM0A2cjYqw7fif7ydWHWWIuVlu6NNzmr6gZBRwZAUZBV6BG2xRXTpUDnoueHWkbwy3"
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

