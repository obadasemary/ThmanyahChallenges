//
//  Endpoint.swift
//  ThmanyahNetworkLayer
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case patch   = "PATCH"
}

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: [String: Any]? { get }
    var contentType: String { get }
}

public extension Endpoint {
    var baseURL: String { "" }
    var method: HTTPMethod { .get }
    var headers: HTTPHeaders { ["Content-Type": contentType] }
    var parameters: [String: Any]? { nil }
    var contentType: String { "application/json" }
}
