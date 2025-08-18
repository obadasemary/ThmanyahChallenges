//
//  DevPreview.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import SwiftUI
import ThmanyahCoreAPI
import ThmanyahUseCase
import ThmanyahRepository
import DependencyContainer
import ThmanyahNetworkLayer

@MainActor
class DevPreview {
    
    static let shared = DevPreview()
    
    var container: DIContainer {
        
        let container = DIContainer()
        
        container.register(NetworkService.self) {
            URLSessionNetworkService(session: .shared)
        }
        
        container.register(HomeFeedRepositoryProtocol.self) {
            HomeFeedRepository(
                networkService: container.resolve(NetworkService.self)!
            )
        }
        
        container.register(SearchRepositoryProtocol.self) {
            SearchRepository(
                networkService: container.resolve(NetworkService.self)!
            )
        }
        
        container.register(HomeFeedUseCaseProtocol.self) {
            HomeFeedUseCase(container: container)
        }
        
        return container
    }
}

extension View {
    func previewEnvironment() -> some View {
        self
            .environment(
                HomeFeedBuilder(container: DevPreview.shared.container)
            )
            .environment(SearchBuilder(container: DevPreview.shared.container))
    }
}
