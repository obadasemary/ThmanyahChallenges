//
//  TabBarBuilder.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import DependencyContainer

@Observable
@MainActor
final class TabBarBuilder {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    func buildTabBarView() -> some View {
        TabBarView()
    }
}
