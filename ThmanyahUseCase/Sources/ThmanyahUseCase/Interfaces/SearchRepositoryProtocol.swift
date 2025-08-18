//
//  SearchRepositoryProtocol.swift
//  ThmanyahUseCase
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation

@MainActor
public protocol SearchRepositoryProtocol {
    func search(term: String) async throws -> SearchResponse
}


