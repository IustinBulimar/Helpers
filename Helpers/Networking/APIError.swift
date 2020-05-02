//
//  APIError.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case invalidUrl
    case badResponse
    case validation(statusCode: Int)
    case wrongMimeType
    case noData
    case badModelDecoding
    case generic(description: String)
    
    init(error: Error) {
        self = .generic(description: error.localizedDescription)
    }
    
}
