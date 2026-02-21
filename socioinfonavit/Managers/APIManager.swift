//
//  APIManager.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    enum APIManagerError: Error {
        case invalidURL
        case invalidResponse
        case requestFailed(statusCode: Int)
    }
    
    private init() {}
    
    private let apiUrl = "https://qa-api.socioinfonavit.com/api/v2"
    
    func execute<T: Decodable, Body: Encodable>(
        _ path: String,
        method: HTTPMethod = .GET,
        headers: [String: String]? = nil,
        body: Body? = nil,
    ) async throws -> T {
        
        guard let url = URL(string: "\(apiUrl)\(path)") else {
            throw APIManagerError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIManagerError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw APIManagerError.requestFailed(statusCode: httpResponse.statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
