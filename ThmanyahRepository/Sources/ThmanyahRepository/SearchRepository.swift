//
//  SearchRepository.swift
//  ThmanyahRepository
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import ThmanyahNetworkLayer
import ThmanyahCoreAPI
import ThmanyahUseCase

@MainActor
@Observable
public final class SearchRepository {
    private let networkService: NetworkService

    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension SearchRepository: SearchRepositoryProtocol {
    public func search(term: String) async throws -> ThmanyahUseCase.SearchResponse {
        let endpoint = ThmanyahCoreAPI.SearchEndpoint.search(term: term)
        return try await networkService
            .request(
                endpoint: endpoint,
                responseModel: ThmanyahUseCase.SearchResponse.self
            )
    }
}


