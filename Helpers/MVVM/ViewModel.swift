//
//  ViewModel.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

protocol ViewModel: class {
    associatedtype APIManager: GenericAPIManager
    
    var view: View! { get set }
    var apiManager: APIManager { get set }
    var coordinator: Coordinator { get set }
    
    func didTapBackButton()
    
}

extension ViewModel {
    
    func didTapBackButton() {
        coordinator.goBack()
    }
    
}
