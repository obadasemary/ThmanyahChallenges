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
        // Build URL with query parameters for GET requests
        let urlString = endpoint.baseURL + endpoint.path
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NetworkError.invalidURL
        }
        if endpoint.method == .get, let params = endpoint.parameters, !params.isEmpty {
            let items: [URLQueryItem] = params.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            // Preserve existing query items if any
            urlComponents.queryItems = (urlComponents.queryItems ?? []) + items
        }
        guard let url = urlComponents.url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        // Encode body for non-GET methods
        if endpoint.method != .get, let params = endpoint.parameters {
            if endpoint.contentType.contains("application/json") {
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        
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
