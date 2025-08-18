//
//  SearchUseCase.swift
//  ThmanyahUseCase
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import DependencyContainer

@MainActor
public protocol SearchUseCaseProtocol {
    func execute(term: String, page: Int) async throws -> SearchResponse
}

@Observable
@MainActor
public final class SearchUseCase {
    private let repository: SearchRepositoryProtocol

    public init(container: DIContainer) {
        self.repository = container.resolve(SearchRepositoryProtocol.self)!
    }
}

extension SearchUseCase: SearchUseCaseProtocol {
    public func execute(term: String, page: Int) async throws -> SearchResponse {
        try await repository.search(term: term, page: page)
    }
}


