//
//  TabBarView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI

struct TabBarView: View {
    
    @Environment(HomeFeedBuilder.self) private var homeFeedBuilder
    @Environment(SearchBuilder.self) private var searchBuilder
    
    var body: some View {
        TabView {
            homeFeedBuilder.buildHomeFeedView()
                .tabItem {
                    Label("Explore", systemImage: "eyes")
                }
            searchBuilder.buildSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    TabBarView()
        .previewEnvironment()
}
