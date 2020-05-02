//
//  SearchBar.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        showsCancelButton = false
        placeholder = "Placeholder"
        tintColor = .blue
        textField?.font = .systemFont(ofSize: 16)
        textField?.borderStyle = .none
        textField?.layer.borderWidth = 1
        textField?.layer.borderColor = UIColor.lightGray.cgColor
        textField?.layer.cornerRadius = 4
        
        setPositionAdjustment(UIOffset(horizontal: 5, vertical: 0), for: .search)
        setPositionAdjustment(UIOffset(horizontal: -5, vertical: 0), for: .clear)
        searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
    }
    
}
