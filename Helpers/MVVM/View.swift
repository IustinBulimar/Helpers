//
//  View.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

protocol View: class {
    
    var isLoading: Bool { get set }
    
    func reload()
    
}
