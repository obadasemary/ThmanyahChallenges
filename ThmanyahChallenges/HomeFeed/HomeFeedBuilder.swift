//
//  HomeFeedBuilder.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase
import DependencyContainer

@Observable
@MainActor
final class HomeFeedBuilder {
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func buildHomeFeedView() -> some View {
        HomeFeedView(
            viewModel: HomeFeedViewModel(
                homeFeedUseCase: HomeFeedUseCase(container: container)
            )
        )
    }
}
