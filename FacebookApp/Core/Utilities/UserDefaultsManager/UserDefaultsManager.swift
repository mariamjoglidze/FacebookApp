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
    
    static func retriveTokenFromUserDefaults() -> Bool{
        if  let token = UserDefaults.standard.string(forKey: Strings.token) {
            return true
        } else {
            return false
        }
    }
    
    static func deleteTokenFromUserDefaults(){
        UserDefaults.standard.removeObject(forKey: Strings.token)
        
    }
}


