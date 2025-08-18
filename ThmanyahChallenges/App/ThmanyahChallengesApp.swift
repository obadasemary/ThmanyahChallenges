//
//  ThmanyahChallengesApp.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 15.08.2025.
//

import SwiftUI
import ThmanyahUseCase

@main
struct ThmanyahChallengesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            delegate.homeFeedBuilder.buildHomeFeedView()
                .environment(delegate.homeFeedBuilder)
                .environment(delegate.searchBuilder)
        }
    }
}
