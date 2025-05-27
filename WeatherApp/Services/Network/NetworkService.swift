//
//  BaseNetworkService.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 27.05.2025.
//

import Foundation
import Moya

final class NetworkService {
    static let shared = NetworkService()
    
    private let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin()])
        
    func request<T: TargetType, Response: Decodable>(_ target: T) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedResponse = try JSONDecoder().decode(Response.self, from: response.data)
                        continuation.resume(returning: decodedResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
