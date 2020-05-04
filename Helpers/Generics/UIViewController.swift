//
//  UIViewController.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instance(storyboardName: String? = nil) -> Self {
        return genericInstance(storyboardName: storyboardName)
    }
    
    private static func genericInstance<ViewController: UIViewController>(storyboardName: String? = nil) -> ViewController {
        let storyboard = UIStoryboard(name: storyboardName ?? "\(ViewController.self)", bundle: Bundle(for: ViewController.self))
        
        guard let viewController =
            (storyboard.instantiateViewController(withIdentifier: "\(ViewController.self)") as? ViewController)
            ?? (storyboard.instantiateInitialViewController() as? ViewController) else {
            fatalError("ViewController is not set as initial or has no identifier or is not of the expected class \(ViewController.self).")
        }
        return viewController
    }
    
}

