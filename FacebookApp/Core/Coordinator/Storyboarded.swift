//
//  Storyboarded.swift
//  FacebookApp
//
//  Created by Mariam Joglidze on 20.01.22.
//

import UIKit

public protocol Storyboarded {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension Storyboarded {
    
    public static var storyboardName: String { String(describing: self) }
    public static var storyboardIdentifier: String { String(describing: self) }
}

// MARK: - Extenstion Storyboarded
extension Storyboarded where Self: UIViewController {
    
    public static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName.replacingOccurrences(of: Strings.viewController, with: Strings.emptyString), bundle: nil)
        guard let viewController: Self
                = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
                as? Self else {
    
                    fatalError(Strings.failedVC + storyboardIdentifier
                               + Strings.fromStoryboard + storyboardName)
                }
        return viewController
    }
    
    
}
