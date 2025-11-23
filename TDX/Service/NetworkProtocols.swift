//
//  NetworkProtocols.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//

import Foundation

protocol AuthProviderProtocol {
    func bearToken() -> String?
}

protocol NetworkServiceProtocol {
//    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

enum NetworkError{
    case invalidURL
    case invalidResponse(statusCode: Int)
    case decodingError(Error)
    case domainError(Error)
}
