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
    
    func getFacebookInfo()
}

class SettingsScreenViewModel: SettingsScreenViewModelProtocol {
    var imageData:  ((Data)->())?
    var userName: ((String)->())?
    
    func getFacebookInfo(){
        
        let requestMe = GraphRequest(graphPath: "me",
                                     parameters: ["fields" : "id,name,email,picture.type(large)"],
                                     tokenString: "EAAHLlZCGjQWYBAHa2U8utqsUMgr8CWLQK2zgHYaKxmKFPr7VnGcPI4l1DQK2o9iGwZBokpNJvtDb79k3wKDxZBYfuG81PdIsR2sbFAyNZCMgyOctqtLxzMEST2pDmBMAfYSa4T7UfZCGDYfZC6G04cYzet9wUbAleFTO7QbZBCzZBJTsZBffLCkJmvM1jj0HitZAlXGFMDc2MTia49cgCXdF3F",
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
                            print(userresult)
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
                }
            }
        })
        connection.start()
    }
}
