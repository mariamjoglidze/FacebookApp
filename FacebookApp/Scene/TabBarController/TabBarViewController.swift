//
//  TabBarViewController.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 18.01.22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeFeedScreenViewController = self.viewControllers![0] as! HomeFeedScreenViewController
        
        let videoesScreenViewController = self.viewControllers![1] as! VideoesScreenViewController
        
        let friendsListScreenViewController = self.viewControllers![2] as! FriendsListScreenViewController
        
        let settingsScreenViewController = self.viewControllers![3] as! SettingsScreenViewController
    }
    
}

