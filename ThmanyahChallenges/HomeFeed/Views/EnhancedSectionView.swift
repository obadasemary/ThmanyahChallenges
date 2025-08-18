//
//  EnhancedSectionView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

// MARK: - EnhancedSectionView
struct EnhancedSectionView: View {
    let section: FeedSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.Spacing.medium) {
            SectionHeader(section: section)
            SectionContent(section: section)
        }
        .accessibilityIdentifier("enhanced_section_\(section.id)")
    }
}

// MARK: - SectionHeader
private struct SectionHeader: View {
    let section: FeedSection
    
    var body: some View {
        HStack {
            HStack(spacing: UIConstants.Spacing.extraSmall) {
                Text(section.name)
                    .font(UIConstants.Typography.sectionHeader)
                    .foregroundColor(.primary)
                    .accessibilityIdentifier("header_title_\(section.id)")
                
                // Show featured indicator based on priority or order
                if section.order <= 3 {
                    Image(systemName: "staroflife.circle.fill")
                        .font(UIConstants.Typography.sectionHeader)
                        .foregroundColor(UIConstants.Colors.accent)
                }
            }
            
            Spacer()
            
            Button(action: {
                // Navigate to see all
            }) {
                Image(systemName: "chevron.right")
                    .font(UIConstants.Typography.caption)
                    .foregroundColor(UIConstants.Colors.secondaryText)
                    .accessibilityIdentifier("header_more_\(section.id)")
            }
            .accessibilityIdentifier("header_see_all_\(section.id)")
        }
        .padding(.horizontal, UIConstants.Spacing.large)
    }
}

// MARK: - SectionContent
private struct SectionContent: View {
    let section: FeedSection
    
    var body: some View {
        switch section.type {
        case .queue:
            QueueSectionView(content: getMediaItems(from: section))
        case .square:
            SquareSectionView(content: getMediaItems(from: section))
        case .big_square:
            BigSquareSectionView(content: getMediaItems(from: section))
        case ._2_lines_grid:
            TwoLinesGridSectionView(content: getMediaItems(from: section))
        }
    }
    
    private func getMediaItems(from section: FeedSection) -> [any MediaItem] {
        switch section.content {
        case .podcasts(let podcasts):
            return podcasts
        case .episodes(let episodes):
            return episodes
        case .audioBooks(let books):
            return books
        case .audioArticles(let articles):
            return articles
        }
    }
}

#Preview {
    EnhancedSectionView(
        section: FeedSection(
            id: "1",
            name: "Top Podcasts",
            type: .square,
            contentType: .podcast,
            order: 1,
            content: .podcasts(
                [
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
                ]
            )
        )
    )
    .padding()
}
