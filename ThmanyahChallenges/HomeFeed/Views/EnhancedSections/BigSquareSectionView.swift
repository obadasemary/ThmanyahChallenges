//
//  BigSquareSectionView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

// MARK: - BigSquareSectionView
struct BigSquareSectionView: View {
    let content: [any MediaItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(content, id: \.id) { item in
                    BigSquareCard(item: item)
                }
            }
            .padding(.horizontal, 20)
        }
        .accessibilityIdentifier("big_square_section")
    }
}

#Preview {
    BigSquareSectionView(content: [
        Podcast(
            podcastID: "1",
            name: "Sample Podcast 1",
            description: "Sample description 1",
            avatarURLString: "https://example.com/image1.jpg",
            episodeCount: 10,
            duration: 3600,
            language: "Arabic",
            priority: 1,
            popularityScore: 100,
            score: 4.5
        ),
        Podcast(
            podcastID: "2",
            name: "Sample Podcast 2",
            description: "Sample description 2",
            avatarURLString: "https://example.com/image2.jpg",
            episodeCount: 15,
            duration: 5400,
            language: "Arabic",
            priority: 2,
            popularityScore: 95,
            score: 4.3
        )
    ])
    .padding()
}
