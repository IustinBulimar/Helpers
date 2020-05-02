//
//  UISearchBar.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

extension UISearchBar {

    var textField : UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            for view in self.subviews[0].subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}
