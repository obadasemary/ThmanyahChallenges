//
//  HomeFeedRepository.swift
//  ThmanyahRepository
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation
import ThmanyahNetworkLayer
import ThmanyahCoreAPI
import ThmanyahUseCase

@MainActor
@Observable
public final class HomeFeedRepository {
    
    private let networkService: NetworkService
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension HomeFeedRepository: HomeFeedRepositoryProtocol {
    
    public func fetchSections(page: Int) async throws -> ThmanyahUseCase.HomeSectionsResponse {
        let endPoint = ThmanyahCoreAPI.HomeFeedEndpoint.getHomeSections(page: page)
        return try await networkService.request(
            endpoint: endPoint,
            responseModel: ThmanyahUseCase.HomeSectionsResponse.self
        )
    }
}
