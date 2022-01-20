//
//  Coordinator.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//


import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator {
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)

    func start()
   
}
