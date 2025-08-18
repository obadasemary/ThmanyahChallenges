//
//  MockResponse.swift
//  ThmanyahNetworkLayer
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation

struct MockResponse: Decodable {
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}
