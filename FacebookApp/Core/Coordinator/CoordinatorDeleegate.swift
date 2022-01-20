//
//  CoordinatorDeleegate.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

// MARK: - CoordinatorDelegate
protocol CoordinatorDelegate: UIViewController {
    var coordinator: Coordinator? { get set }
}

