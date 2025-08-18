//
//  MockEndpoint.swift
//  ThmanyahNetworkLayer
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation
@testable import ThmanyahNetworkLayer

struct MockEndpoint: Endpoint {
    var path: String = "https://mockapi.com/user"
    var method: String = "GET"
    var headers: [String: String]? = nil
    var parameters: [String: Any]? = nil
    var contentType: String = ""
}
