//
//  SearchEndpoint.swift
//  ThmanyahCoreAPI
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import ThmanyahNetworkLayer

public enum SearchEndpoint {
    case search(term: String)
}

extension SearchEndpoint: Endpoint {
    public var baseURL: String { "https://mock.apidog.com/m1/735111-711675-default" }
    
    public var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .search(let term):
            return ["q": term]
        }
    }
    
    public var contentType: String { "application/json" }
}
