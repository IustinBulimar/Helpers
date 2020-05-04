//
//  Bundle.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

extension Bundle {
    
    static var current: Bundle { return Bundle(for: CurrentBundle.self) }
    
    private final class CurrentBundle {}
    
}
