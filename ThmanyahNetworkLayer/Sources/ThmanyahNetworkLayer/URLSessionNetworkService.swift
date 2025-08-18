//
//  URLSessionNetworkService.swift
//  ThmanyahNetworkLayer
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
}

@MainActor
public final class URLSessionNetworkService {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
}

extension URLSessionNetworkService: NetworkService {
    
    public func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch let decodingError as DecodingError {
            switch decodingError {
            case .keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .typeMismatch(let type, let context):
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .valueNotFound(let value, let context):
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .dataCorrupted(let context):
                print("Data corrupted:", context.debugDescription)
                print("codingPath:", context.codingPath)
            @unknown default:
                print("Unknown decoding error")
            }
            throw NetworkError.decodingError
        } catch {
            print("Other error: \(error.localizedDescription)")
            throw NetworkError.decodingError
        }
    }
}
