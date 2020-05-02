//
//  UICollectionView.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: "\(cellClass)", bundle: Bundle(for: Cell.self)),
                      forCellWithReuseIdentifier: "\(cellClass)")
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(ofType type: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: "\(type)", for: indexPath) as? Cell else {
            fatalError("Cell has no identifier or is not of the expected class \(type).")
        }
        return cell
    }
    
}
