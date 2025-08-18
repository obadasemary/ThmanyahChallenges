//
//  AppComposition.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import ThmanyahNetworkLayer
import ThmanyahCoreAPI
import ThmanyahRepository
import ThmanyahUseCase

@MainActor
final class AppComposition {
    
    let container = DependencyContainer()
    
    init() {
        
        container.register(NetworkService.self) {
            URLSessionNetworkService(session: .shared)
        }
        
        container.register(HomeFeedRepositoryProtocol.self) {
            HomeFeedRepository(
                networkService: self.container.resolve(NetworkService.self)!
            )
        }
        
        container.register(HomeFeedUseCaseProtocol.self) {
            HomeFeedUseCase(
                homeFeedRepository: self.container
                    .resolve(HomeFeedRepositoryProtocol.self)!
            )
        }
    }
}
