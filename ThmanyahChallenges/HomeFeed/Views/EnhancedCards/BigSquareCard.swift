//
//  BigSquareCard.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

// MARK: - BigSquareCard
struct BigSquareCard: View {
    let item: MediaItem
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            BackgroundImage()
            GradientOverlay()
            ContentOverlay()
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .accessibilityIdentifier("big_square_card")
        .accessibilityLabel("Big square content card")
    }
    
    @ViewBuilder
    private func BackgroundImage() -> some View {
        AsyncImage(url: item.avatarURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .fill(Color(.systemGray4))
        }
        .frame(width: 300, height: 200)
    }
    
    @ViewBuilder
    private func GradientOverlay() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(.systemBackground).opacity(0.8),
                Color(.systemBackground).opacity(0.4),
                Color.clear
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    @ViewBuilder
    private func ContentOverlay() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            if let episodeCount = getEpisodeCount() {
                Text("\(episodeCount) حلقات")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func getEpisodeCount() -> Int? {
        if let podcast = item as? Podcast {
            return podcast.episodeCount
        }
        return nil
    }
}

#Preview {
    BigSquareCard(item: Podcast(
        podcastID: "1",
        name: "Sample Podcast with a longer name to test line limit and wrapping behavior",
        description: "Sample description",
        avatarURLString: "https://example.com/image.jpg",
        episodeCount: 25,
        duration: 3600,
        language: "Arabic",
        priority: 1,
        popularityScore: 100,
        score: 4.5
    ))
    .frame(width: 300, height: 200)
    .padding()
}
