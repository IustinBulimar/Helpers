//
//  SearchController.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

class SearchController: UISearchController, UISearchBarDelegate {

    lazy var _searchBar: SearchBar = { [unowned self] in
        let result = SearchBar(frame: .zero)
        result.delegate = self

        return result
    }()

    override var searchBar: UISearchBar {
        get {
            return _searchBar
        }
    }
}
