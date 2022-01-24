//
//  SignInViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 23.01.22.
//

import Foundation
import FBSDKLoginKit

protocol SignInScreenViewModelProtocol {
    var navigate: (()->())? {get set}

    func signIn()
}

class SignInScreenViewModel: SignInScreenViewModelProtocol {
    var navigate: (()->())?

    func signIn(){
        let token = Strings.token
        let request = FBSDKLoginKit.GraphRequest(graphPath: Strings.me,
                                                 parameters: [Strings.fields: "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completion:{ connection, result, error in
            let loginManager = LoginManager()

            let sb = UIStoryboard(name: Strings.tabBar, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: Strings.tabBarViewController)
            loginManager.logIn(permissions: ["public_profile", "email"], viewController: vc) { result in
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                self.navigate?()
            }
        })
    }
}