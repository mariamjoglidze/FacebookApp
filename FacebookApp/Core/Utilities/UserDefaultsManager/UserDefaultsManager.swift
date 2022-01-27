//
//  UserDefaultsManager.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 21.01.22.
//

import Foundation

class UserDefaultsManager {
    
    static func saveTokenInUserDefaults(with token: String){
        UserDefaults.standard.set(token, forKey: Strings.token)
        print("saved")
        
    }
    
    static func retriveTokenFromUserDefaults() -> String{
        let token = UserDefaults.standard.object(forKey: Strings.token) as? String
        return token ?? ""
        
    }
    
    static func deleteTokenFromUserDefaults(){
        UserDefaults.standard.removeObject(forKey: Strings.token)
        UserDefaults.standard.synchronize()
    }
}


