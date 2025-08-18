//
//  HomeFeedBuilder.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

@Observable
@MainActor
final class HomeFeedBuilder {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func buildHomeFeedView() -> some View {
        let useCase = container.resolve(HomeFeedUseCaseProtocol.self)!
        let vm = HomeFeedViewModel(homeFeedUseCase: useCase)
        return HomeFeedView(viewModel: vm)
    }
}
