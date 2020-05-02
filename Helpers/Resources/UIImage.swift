//
//  UIImage.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func image(named name: String, in bundle: Bundle? = nil, compatibleWith traitsCollection: UITraitCollection? = nil) -> UIImage {
        guard let image = UIImage(named: name, in: bundle, compatibleWith: traitsCollection) else {
            fatalError("Could not find an image named \(name)")
        }
        return image
    }
    

    func withTint(color: UIColor) -> UIImage? {
      
      UIGraphicsBeginImageContext(size)
      guard let context = UIGraphicsGetCurrentContext(),
       let cgImage = cgImage else {
          return nil
      }
    
      context.scaleBy(x: 1.0, y: -1.0)
      context.translateBy(x: 0.0, y: -self.size.height)
      context.setBlendMode(.multiply)
      
      let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
      context.clip(to: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height),
                   mask: cgImage)
      
      color.setFill()
      context.fill(rect)
      
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return newImage
      
    }
    
}
