//
//  AppComposition.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import DependencyContainer
import ThmanyahNetworkLayer
import ThmanyahCoreAPI
import ThmanyahRepository
import ThmanyahUseCase

@MainActor
final class AppComposition {
    
    var container = DIContainer()
    let homeFeedUseCase: HomeFeedUseCaseProtocol
    let searchUseCase: SearchUseCaseProtocol
    
    init() {
        
        let container = container
        
        container.register(NetworkService.self) {
            URLSessionNetworkService(session: .shared)
        }
        
        container.register(HomeFeedRepositoryProtocol.self) {
            HomeFeedRepository(
                networkService: container.resolve(NetworkService.self)!
            )
        }
        
        container.register(HomeFeedUseCaseProtocol.self) {
            HomeFeedUseCase(container: container)
        }
        
        container.register(SearchRepositoryProtocol.self) {
            SearchRepository(
                networkService: container.resolve(NetworkService.self)!
            )
        }
        
        container.register(SearchUseCaseProtocol.self) {
            SearchUseCase(container: container)
        }
        
        homeFeedUseCase = container.resolve(HomeFeedUseCaseProtocol.self)!
        searchUseCase = container.resolve(SearchUseCaseProtocol.self)!
        self.container = container
    }
}
