//
//  SearchResponse.swift
//  ThmanyahUseCase
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation

public struct SearchResponse: Codable, Equatable, Sendable {
    
    public let results: [SearchResult]

    public init(results: [SearchResult]) {
        self.results = results
    }

    private enum CodingKeys: String, CodingKey {
        case results
        case pagination
        case sections
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Try to decode the standard format first
        if let decodedResults = try? container.decode([SearchResult].self, forKey: .results) {
            self.results = decodedResults
        } else if container.contains(.sections) {
            // Handle the real API structure with sections
            let sections = try container.decode([SearchSection].self, forKey: .sections)
            self.results = sections.flatMap { section in
                section.content?.compactMap { contentItem in
                    contentItem.toSearchResult()
                } ?? []
            }
        } else {
            self.results = []
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
}

public enum SearchResult: Codable, Equatable, Sendable, Identifiable {
    case podcast(Podcast)
    case episode(Episode)
    case audioBook(AudioBook)
    case audioArticle(AudioArticle)

    public var id: String {
        switch self {
        case .podcast(let p): return "podcast_" + p.id
        case .episode(let e): return "episode_" + e.id
        case .audioBook(let b): return "audiobook_" + b.id
        case .audioArticle(let a): return "article_" + a.id
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case payload
    }

    private enum ResultType: String, Codable {
        case podcast
        case episode
        case audio_book
        case audio_article
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ResultType.self, forKey: .type)
        switch type {
        case .podcast:
            let p = try container.decode(Podcast.self, forKey: .payload)
            self = .podcast(p)
        case .episode:
            let e = try container.decode(Episode.self, forKey: .payload)
            self = .episode(e)
        case .audio_book:
            let b = try container.decode(AudioBook.self, forKey: .payload)
            self = .audioBook(b)
        case .audio_article:
            let a = try container.decode(AudioArticle.self, forKey: .payload)
            self = .audioArticle(a)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .podcast(let p):
            try container.encode(ResultType.podcast, forKey: .type)
            try container.encode(p, forKey: .payload)
        case .episode(let e):
            try container.encode(ResultType.episode, forKey: .type)
            try container.encode(e, forKey: .payload)
        case .audioBook(let b):
            try container.encode(ResultType.audio_book, forKey: .type)
            try container.encode(b, forKey: .payload)
        case .audioArticle(let a):
            try container.encode(ResultType.audio_article, forKey: .type)
            try container.encode(a, forKey: .payload)
        }
    }
}

// Real API response structures to handle the sections format
private struct SearchSection: Codable {
    let name: String
    let type: String
    let content_type: String
    let order: String
    let content: [ContentItem]?
}

private struct ContentItem: Codable {
    // The mock API returns podcast objects directly in content
    let podcast_id: String?
    let name: String?
    let description: String?
    let avatar_url: String?
    let episode_count: String?
    let duration: String?
    let language: String?
    let priority: String?
    let popularityScore: String?
    let score: String?
    
    func toSearchResult() -> SearchResult? {
        guard let id = podcast_id, let name = name else { return nil }
        
        let podcast = Podcast(
            podcastID: id,
            name: name,
            description: description,
            avatarURLString: avatar_url,
            episodeCount: Int(episode_count ?? "0"),
            duration: TimeInterval(duration ?? "0"),
            language: language,
            priority: Int(priority ?? "0"),
            popularityScore: Int(popularityScore ?? "0"),
            score: Double(score ?? "0")
        )
        
        return .podcast(podcast)
    }
}


