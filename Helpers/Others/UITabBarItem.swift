//
//  UITabBarItem.swift
//  Helpers
//
//  Created by Iustin Bulimar on 04/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

extension UITabBarItem {
    
    static func item(title: String, image: UIImage? = nil, selectedImage: UIImage? = nil) -> UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
    
}
