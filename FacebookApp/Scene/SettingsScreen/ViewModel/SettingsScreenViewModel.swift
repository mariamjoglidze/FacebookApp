//
//  SettingsScreenViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 21.01.22.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

protocol SettingsScreenViewModelProtocol {
    var imageData: ((Data)->())? {get set}
    var userName: ((String)->())? {get set}
    var showLoading: (()->())? {get set}
    var hideLoading: (()->())? {get set}
    var navigate: (()->())? {get set}

    func getFacebookInfo()
    func logOut()
}

class SettingsScreenViewModel: SettingsScreenViewModelProtocol {
    var imageData:  ((Data)->())?
    var userName: ((String)->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var navigate: (()->())?


    func getFacebookInfo(){
        showLoading?()
        let requestMe = GraphRequest(graphPath: Strings.me,
                                     parameters: [Strings.fields : "id,name,email,picture.type(large)"],
                                     tokenString: Strings.token,
                                     version: nil,
                                     httpMethod: .get)
        
        let connection = GraphRequestConnection()
        connection.add(requestMe, completion:{ (connectn, userresult, error) in
            if let dictData: [String : Any] = userresult as? [String : Any]
            {
                DispatchQueue.main.async
                {
                    if let pictureData: [String : Any] = dictData["picture"] as? [String : Any]
                    {
                        if let data : [String: Any] = pictureData["data"] as? [String: Any]
                        {
                            if let pictureURL = data["url"]{
                                if let url = URL(string: pictureURL as! String) {
                                    if let data = try? Data(contentsOf: url) {
                                        self.imageData!(data)
                                        
                                    }
                                }
                            }
                            if let userName = dictData["name"] as? String{
                                self.userName!(userName)

                            }
                        }
                    }
                    self.hideLoading?()
                }
            }
        })
        connection.start()

    }
    
    func logOut(){
        UserDefaultsManager.deleteTokenFromUserDefaults()
        let sb = UIStoryboard(name: Strings.signInScreen, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: Strings.signInScreenViewController)
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigate?()
    }
}
