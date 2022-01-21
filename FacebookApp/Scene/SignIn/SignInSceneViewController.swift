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
        let token = "EAAHLlZCGjQWYBAF52pgi6eKMPzmQ6c13pt7OYjsxI2WoHtv31mPYWzVkUqXHF40C7iPhzMUcO5AZAeuHIB9zoZAkwGF58uZABnHY7iwCFm8jSZCqzLVmoJt1ZAwjqLZBWi7zhHZCELlQIh4zHpxrg7OIBTgQ6PHtC7Sk0vb9oo9ZA2ilLZAnpvD3UgOHeFdl1PmQ7JrKAuh9v8joBBPq0WGHzN"
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

