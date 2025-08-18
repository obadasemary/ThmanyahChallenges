//
//  SectionView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

struct SectionView: View {
    
    let section: FeedSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(section.name)
                .font(.headline)
            
            switch section.content {
            case .podcasts(let podcasts):
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(podcasts) { podcast in
                            podcastsSection(
                                layout: section.type,
                                items: podcasts
                            )
                        }
                    }
                }
            case .episodes(let episodes):
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(episodes) { episode in
                            episodesSection(
                                layout: section.type,
                                items: episodes
                            )
                        }
                    }
                }
            case .audioBooks(let books):
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(books) { book in
                            booksSection(layout: section.type, items: books)
                        }
                    }
                }
            case .audioArticles(let articles):
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(articles) { article in
                            articlesSection(
                                layout: section.type,
                                items: articles
                            )
                        }
                    }
                }
            }
        }
    }
}

extension SectionView {
    
    @ViewBuilder
    fileprivate func podcastsSection(layout: SectionLayout, items: [Podcast]) -> some View {
        switch layout {
        case .square, .queue:
            horizontalCards(items)
        case .big_square:
            MediaBigSquareGrid(items: items)
        case ._2_lines_grid:
            verticalEpisodeRows(items.map(asEpisode(from:)))
        }
    }

    @ViewBuilder
    fileprivate func episodesSection(layout: SectionLayout, items: [Episode]) -> some View {
        switch layout {
        case ._2_lines_grid:
            verticalEpisodeRows(items)
        case .square, .queue:
            horizontalCards(items)
        case .big_square:
            MediaBigSquareGrid(items: items)
        }
    }

    @ViewBuilder
    fileprivate func booksSection(layout: SectionLayout, items: [AudioBook]) -> some View {
        switch layout {
        case .big_square:
            MediaBigSquareGrid(items: items)
        case .square, .queue:
            horizontalCards(items)
        case ._2_lines_grid:
            verticalEpisodeRows(items.map(asEpisode(from:)))
        }
    }

    @ViewBuilder
    fileprivate func articlesSection(layout: SectionLayout, items: [AudioArticle]) -> some View {
        switch layout {
        case .square, .queue:
            horizontalCards(items)
        case .big_square:
            MediaBigSquareGrid(items: items)
        case ._2_lines_grid:
            verticalEpisodeRows(items.map(asEpisode(from:)))
        }
    }

    @ViewBuilder
    fileprivate func horizontalCards<T: MediaItem>(_ items: [T]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(items, id: \.id) { item in
                    MediaCardSquare(item: item)
                }
            }
            .padding(.horizontal, 4)
        }
    }

    @ViewBuilder
    fileprivate func verticalEpisodeRows(_ items: [Episode]) -> some View {
        LazyVStack(spacing: 12) {
            ForEach(items, id: \.id) { episode in
                EpisodeTwoLineRow(episode: episode)
            }
        }
    }

    // MARK: - Mappers
    fileprivate func asEpisode(from podcast: Podcast) -> Episode {
        Episode(
            episodeID: podcast.id,
            name: podcast.name,
            seasonNumber: nil,
            episodeType: nil,
            podcastName: nil,
            authorName: nil,
            description: podcast.descriptionHTML,
            avatarURLString: podcast.avatarURL?.absoluteString,
            audioURLString: nil,
            separatedAudioURL: nil,
            duration: podcast.duration,
            releaseDate: nil,
            podcastID: podcast.id,
            podcastPriority: nil,
            podcastPopularityScore: nil,
            score: nil
        )
    }

    fileprivate func asEpisode(from book: AudioBook) -> Episode {
        Episode(
            episodeID: book.id,
            name: book.name,
            seasonNumber: nil,
            episodeType: nil,
            podcastName: book.authorName,
            authorName: nil,
            description: book.descriptionHTML,
            avatarURLString: book.avatarURL?.absoluteString,
            audioURLString: nil,
            separatedAudioURL: nil,
            duration: book.duration,
            releaseDate: book.releaseDate,
            podcastID: nil,
            podcastPriority: nil,
            podcastPopularityScore: nil,
            score: book.score
        )
    }

    fileprivate func asEpisode(from article: AudioArticle) -> Episode {
        Episode(
            episodeID: article.id,
            name: article.name,
            seasonNumber: nil,
            episodeType: nil,
            podcastName: article.authorName,
            authorName: nil,
            description: article.descriptionHTML,
            avatarURLString: article.avatarURL?.absoluteString,
            audioURLString: nil,
            separatedAudioURL: nil,
            duration: article.duration,
            releaseDate: article.releaseDate,
            podcastID: nil,
            podcastPriority: nil,
            podcastPopularityScore: nil,
            score: article.score
        )
    }
}
