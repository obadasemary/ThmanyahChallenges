//
//  HomeFeedEndpoint.swift
//  ThmanyahCoreAPI
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import ThmanyahNetworkLayer

public enum HomeFeedEndpoint {
    case getHomeSections(page: Int?)
}

extension HomeFeedEndpoint: Endpoint {
    
    // Base URL for the API
    public var baseURL: String {
        return "https://api-v2-b2sit6oh3a-uc.a.run.app"
    }
    
    // Path for each case
    public var path: String {
        switch self {
        case .getHomeSections(page: _):
            "/home_sections"
        }
    }
    
    // HTTP method for each case
    public var method: HTTPMethod {
        switch self {
        case .getHomeSections:
            return .get
        }
    }
    
    // Parameters are nil for GET requests
    public var parameters: [String: Any]? {
        switch self {
        case .getHomeSections(let page):
            if let page {
                return ["page": page]
            }
            return nil
        }
    }
    
    // Content type for requests
    public var contentType: String {
        return "application/json"
    }
}
