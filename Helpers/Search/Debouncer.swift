//
//  Debouncer.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

protocol Debouncer: class {
    var debounceTimer: Timer? { get set }
    func debounce(timeInterval: TimeInterval, completion: @escaping () -> Void)
}

extension Debouncer {
    
    func debounce(timeInterval: TimeInterval, completion: @escaping () -> Void) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] timer in
            guard timer.isValid else {
                return
            }
            self?.debounceTimer = nil
            completion()
        }
    }
    
}
