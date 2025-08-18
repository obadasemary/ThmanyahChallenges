//
//  FeaturedCard.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

// MARK: - FeaturedCard
struct FeaturedCard: View {
    let item: any MediaItem
    @Environment(\.theme) private var theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.medium) {
            ContentAsyncImage(
                url: item.avatarURL,
                size: theme.imageSize.extraLarge,
                cornerRadius: theme.cornerRadius.large
            )
            
            ContentInfo()
        }
        .frame(width: 200)
        .accessibilityIdentifier("featured_card")
        .accessibilityLabel("Featured content card")
    }
    
    @ViewBuilder
    private func ContentInfo() -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            // Show description if available
            if let description = item.descriptionHTML, !description.isEmpty {
                Text(description)
                    .font(theme.typography.caption)
                    .foregroundColor(theme.colors.secondaryText)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(item.name)
                .font(theme.typography.headline)
                .fontWeight(.semibold)
                .foregroundColor(theme.colors.text)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ActionRow()
        }
    }
    
    private func ActionRow() -> some View {
        HStack {
            ActionButtons()
            Spacer()
            if let duration = item.duration {
                DurationCard(duration: duration)
            }
        }
    }
    
    private func ActionButtons() -> some View {
        HStack(spacing: theme.spacing.small) {
            Button(action: {
                // Play action
            }) {
                Image(systemName: "play.fill")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(theme.colors.background)
                    .frame(width: 32, height: 32)
                    .background(theme.colors.primary)
                    .clipShape(Circle())
            }
            .accessibilityIdentifier("play_button")
            
            Button(action: {
                // Add to queue action
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(theme.colors.text)
                    .frame(width: 32, height: 32)
                    .background(theme.colors.cardBackground)
                    .clipShape(Circle())
            }
            .accessibilityIdentifier("add_to_queue_button")
        }
    }
    
    // MARK: - ContentAsyncImage
    private struct ContentAsyncImage: View {
        let url: URL?
        let size: CGSize
        let cornerRadius: CGFloat
        @Environment(\.theme) private var theme
        
        var body: some View {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(theme.colors.cardBackground)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 24))
                            .foregroundColor(theme.colors.secondaryText)
                    )
            }
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }
    
    // MARK: - DurationCard
    private struct DurationCard: View {
        let duration: TimeInterval
        @Environment(\.theme) private var theme
        
        var body: some View {
            Text(formatDuration(duration))
                .font(theme.typography.caption)
                .foregroundColor(theme.colors.secondaryText)
                .padding(.horizontal, theme.spacing.small)
                .padding(.vertical, theme.spacing.extraSmall)
                .background(theme.colors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius.small, style: .continuous))
        }
        
        private func formatDuration(_ duration: TimeInterval) -> String {
            let minutes = Int(duration) / 60
            let seconds = Int(duration) % 60
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}

// MARK: - Preview
#Preview {
    FeaturedCard(item: Podcast(
        podcastID: "1",
        name: "Sample Podcast",
        description: "This is a sample podcast description that shows how the card looks with content.",
        avatarURLString: nil,
        episodeCount: 10,
        duration: 1800,
        language: "Arabic",
        priority: 1,
        popularityScore: 100,
        score: 4.5
    ))
    .withTheme()
    .padding()
}
