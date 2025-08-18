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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ContentAsyncImage(
                url: item.avatarURL,
                size: CGSize(width: 200, height: 200),
                cornerRadius: 16
            )
            
            ContentInfo()
        }
        .frame(width: 200)
        .accessibilityIdentifier("featured_card")
        .accessibilityLabel("Featured content card")
    }
    
    @ViewBuilder
    private func ContentInfo() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Show description if available
            if let description = item.descriptionHTML, !description.isEmpty {
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(item.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ActionRow()
        }
    }
    
    @ViewBuilder
    private func ActionRow() -> some View {
        HStack(spacing: 16) {
            DurationCard(duration: item.duration, style: .standard)
            
            Spacer()
            
            ActionButtons()
        }
    }
    
    @ViewBuilder
    private func ActionButtons() -> some View {
        HStack(spacing: 16) {
            Button(action: { /* play */ }) {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(.blue)
            }
            
            Button(action: { /* more options */ }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - ContentAsyncImage
private struct ContentAsyncImage: View {
    let url: URL?
    let size: CGSize
    let cornerRadius: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .fill(Color(.systemGray4))
        }
        .frame(width: size.width, height: size.height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

// MARK: - DurationCard
private struct DurationCard: View {
    let duration: TimeInterval?
    let style: DurationStyle
    
    enum DurationStyle {
        case standard
        case compact
    }
    
    var body: some View {
        if let duration = duration {
            Text(Utilities.formatDuration(Int(duration)))
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

#Preview {
    FeaturedCard(item: Podcast(
        podcastID: "1",
        name: "Sample Podcast with a very long name that might wrap to multiple lines",
        description: "This is a sample podcast description that provides context about the content",
        avatarURLString: "https://example.com/image.jpg",
        episodeCount: 10,
        duration: 3600,
        language: "Arabic",
        priority: 1,
        popularityScore: 100,
        score: 4.5
    ))
    .padding()
}
