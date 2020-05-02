//
//  UIFont.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func font(named name: String, size: Int, weight: UIFont.Weight = .regular) -> UIFont {
        let fullName = "\(name)-\(weight)"
        guard let font = UIFont(name: fullName, size: CGFloat(size)) else {
            fatalError("Could not find a font named \(fullName)")
        }
        return font
    }
    
    
    static func registerFont(fileName: String) {
        guard let url = Bundle.current.url(forResource: fileName, withExtension: nil),
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil) else {
                fatalError("Failed to register font: \(fileName)")
        }
    }
    
}

