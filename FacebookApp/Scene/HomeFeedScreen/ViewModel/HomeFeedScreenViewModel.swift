//
//  HomeFeedScreenViewModel.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 24.01.22.
//

import UIKit
import FBSDKLoginKit

protocol HomeFeedScreenViewModelProtocol {
  
    var showLoading: (()->())? {get set}

    func fetchFriendList()
}

class HomeFeedScreenViewModel: HomeFeedScreenViewModelProtocol {
   
    var showLoading: (()->())?

    func fetchFriendList(){
        showLoading?()
        let requestMe = GraphRequest(graphPath: "me/feed",
                                     parameters: [Strings.fields : "id,name, picture.type(large)"],
                                     tokenString: Strings.token,
                                     version: nil,
                                     httpMethod: .get)
        
        requestMe.start(completion:{ connection, result, error in
            
            if let data: [String: Any] = result as? [String: Any] {
                DispatchQueue.main.async
                {
                   
                }
            }
        })
    }
}
