//
//  AppResources.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

extension UIColor {

    static var example: UIColor { return UIColor(rgb: 0xFFFFFF) }
    
}

extension UIImage {
    
    static var example: UIImage { return .image(named: "example") }
    
}

extension UIFont {
    
    static var example: UIFont { return .font(named: "example", size: 16, weight: .regular) }
    
    static func example(size: Int, weight: UIFont.Weight = .regular) -> UIFont { return .font(named: "example", size: size, weight: weight) }
    
}


