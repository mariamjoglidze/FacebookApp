//
//  AppCoordinator.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit


class AppCoordinator: Coordinator {
    
    
    // MARK: - Variables
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    // MARK: - init
    required init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    func start() {
//        let viewController = TabBarViewController.instantiateFromStoryboard()
//        viewController.coordinator = self
//        self.showViewController(viewController)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
        
        let viewController = TabBarViewController.instantiateFromStoryboard()
        viewController.coordinator = self
//        self.present(viewController)
        self.showViewController(viewController)
    }
    

    // MARK: - Push ViewController
    func showViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: false)
    }
}
