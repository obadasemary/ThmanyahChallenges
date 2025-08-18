//
//  NetworkService.swift
//  ThmanyahNetworkLayer
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

@MainActor
@available(macOS 12.0, iOS 15.0, *)
public protocol NetworkService {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}
