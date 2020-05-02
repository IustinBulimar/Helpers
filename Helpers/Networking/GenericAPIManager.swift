//
//  GenericAPIManager.swift
//  Helpers
//
//  Created by Iustin Bulimar on 02/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

class GenericAPIManager: NSObject {

    typealias ResultCompletion<Model: Codable> = (Swift.Result<Model, APIError>) -> Void
    typealias APIRoute = String
    typealias Params = [String: Any]?
    typealias Headers = [String: String]?
    
    enum HTTPMethod {
        case get
        case post
    }
    
    let environment: String
    
    private let defaultHeaders: Headers
    
    private let session = URLSession.shared
    
    private let sessionQueue = DispatchQueue.global()
    
    private var isDebug: Bool
    
    init(environment: String, defaultHeaders: Headers = nil, isDebug: Bool = false) {
        self.environment = environment
        self.defaultHeaders = defaultHeaders
        self.isDebug = isDebug
        
        super.init()
    }
    
    private func createRequest(method: HTTPMethod, relativePath: APIRoute, headers: Headers = nil, params: Params = nil) throws -> URLRequest {
        
        guard let url = URL(string: environment + "/" + relativePath) else {
            throw APIError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        defaultHeaders?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        switch method {
        case .get:
            guard var params = params else {
                break
            }
            if let id = params["id"] {
                request.url = URL(string: "\(request.url!.absoluteString)/\(id)")
                params.removeValue(forKey: "id")
            }
            guard params.count > 0 else {
                break
            }
            
            var queryItems: [URLQueryItem] = []
            var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            for (key, value) in params {
                let value = value as? String ?? "\(value)"
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents?.queryItems = queryItems
            request.url = urlComponents?.url
            
        case .post:
            let data = try JSONSerialization.data(withJSONObject: params as Any, options: [])
            request.httpBody = data
        }
        
        return request
    }
    
    private func sendRequest(request: URLRequest, completion: @escaping ResultCompletion<Data>) {
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.init(error: error!)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.validation(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                completion(.failure(.wrongMimeType))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
            
        }.resume()
    }
    
    func request<Model: Codable>(method: HTTPMethod, remotePath: APIRoute, headers: Headers = nil, params: Params = nil, completion: @escaping ResultCompletion<Model>) {
        
        sessionQueue.async { [weak self] in
            do {
                guard let self = self else { return }
                
                let request = try self.createRequest(method: method, relativePath: remotePath,
                                                     headers: headers, params: params)
                
                self.sendRequest(request: request) { result in
                    switch result {
                    case .success(let data):
                        do {
                            let model = try JSONDecoder().decode(Model.self, from: data)
                            DispatchQueue.main.async {
                                completion(.success(model))
                            }
                        } catch {
                            DispatchQueue.main.async {
                                completion(.failure(.init(error: error)))
                            }
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.init(error: error)))
                }
            }
        }
    }

}
