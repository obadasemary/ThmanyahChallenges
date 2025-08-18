//
//  HomeSectionsResponse.swift
//  ThmanyahUseCase
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation

public struct HomeSectionsResponse: Codable, Equatable, Sendable {
    public let sections: [Section]
    public let pagination: Pagination
}

public enum MediaKind: String, Codable, Sendable {
    case podcast
    case episode
    case audio_book
    case audio_article
}

public enum SectionLayout: String, Sendable {
    case square
    case big_square
    case queue
    case _2_lines_grid = "2_lines_grid"
}

extension SectionLayout: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        // Normalize common variants from the backend (spaces / hyphens / casing)
        let normalized: String = {
            var s = raw.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            s = s.replacingOccurrences(of: " ", with: "_")
            s = s.replacingOccurrences(of: "-", with: "_")
            switch s {
            case "big square", "big__square": return "big_square"
            case "two_lines_grid", "2_line_grid", "two_line_grid", "grid_2_lines": return "2_lines_grid"
            default: return s
            }
        }()
        if let value = SectionLayout(rawValue: normalized) {
            self = value
        } else {
            // Be forgiving: default to .square if an unknown value arrives
            // (alternatively, throw DecodingError.dataCorrupted for strict behavior)
            self = .square
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}

public struct Pagination: Codable, Equatable, Sendable {
    
    public let nextPage: String?
    public let totalPages: Int
    
//    public init(nextPage: String?, totalPages: Int) {
//        self.nextPage = nextPage
//        self.totalPages = totalPages
//    }
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page",
             totalPages = "total_pages"
    }
}

public protocol MediaItem: Identifiable, Equatable, Sendable {
    var id: String { get }
    var name: String { get }
    var avatarURL: URL? { get }
    var descriptionHTML: String? { get }
    var duration: TimeInterval? { get }
}

public struct Podcast: MediaItem, Codable, Equatable, Sendable {
    public let podcastID: String
    public let name: String
    public let description: String?
    public let avatarURLString: String?
    public let episodeCount: Int?
    public let duration: TimeInterval?
    public let language: String?
    public let priority: Int?
    public let popularityScore: Int?
    public let score: Double?
    
    public var id: String { podcastID }
    public var avatarURL: URL? { URL(string: avatarURLString ?? "") }
    public var descriptionHTML: String? { description }
    
    enum CodingKeys: String, CodingKey {
        case podcastID = "podcast_id"
        case name, description
        case avatarURLString = "avatar_url"
        case episodeCount = "episode_count"
        case duration, language, priority, popularityScore, score
    }
}

public struct Episode: MediaItem, Codable, Equatable, Sendable {
    public let episodeID: String
    public let name: String
    public let seasonNumber: Int?
    public let episodeType: String?
    public let podcastName: String?
    public let authorName: String?
    public let description: String?
    public let avatarURLString: String?
    public let audioURLString: String?
    public let separatedAudioURL: String?
    public let duration: TimeInterval?
    public let releaseDate: String?
    public let podcastID: String?
    public let podcastPriority: Int?
    public let podcastPopularityScore: Int?
    public let score: Double?
    
    public var id: String { episodeID }
    public var avatarURL: URL? { URL(string: avatarURLString ?? "") }
    public var descriptionHTML: String? { description }
    public var audioURL: URL? { URL(string: audioURLString ?? "") }
    
    public init(
        episodeID: String,
        name: String,
        seasonNumber: Int?,
        episodeType: String?,
        podcastName: String?,
        authorName: String?,
        description: String?,
        avatarURLString: String?,
        audioURLString: String?,
        separatedAudioURL: String?,
        duration: TimeInterval?,
        releaseDate: String?,
        podcastID: String?,
        podcastPriority: Int?,
        podcastPopularityScore: Int?,
        score: Double?
    ) {
        self.episodeID = episodeID
        self.name = name
        self.seasonNumber = seasonNumber
        self.episodeType = episodeType
        self.podcastName = podcastName
        self.authorName = authorName
        self.description = description
        self.avatarURLString = avatarURLString
        self.audioURLString = audioURLString
        self.separatedAudioURL = separatedAudioURL
        self.duration = duration
        self.releaseDate = releaseDate
        self.podcastID = podcastID
        self.podcastPriority = podcastPriority
        self.podcastPopularityScore = podcastPopularityScore
        self.score = score
    }
    
    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case name
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case description
        case avatarURLString = "avatar_url"
        case audioURLString = "audio_url"
        case separatedAudioURL = "separated_audio_url"
        case duration
        case releaseDate = "release_date"
        case podcastID = "podcast_id"
        case podcastPriority, podcastPopularityScore, score
    }
}

public struct AudioBook: MediaItem, Codable, Equatable, Sendable {
    public let audiobookID: String
    public let name: String
    public let authorName: String?
    public let description: String?
    public let avatarURLString: String?
    public let duration: TimeInterval?
    public let language: String?
    public let releaseDate: String?
    public let score: Double?
    
    public var id: String { audiobookID }
    public var avatarURL: URL? { URL(string: avatarURLString ?? "") }
    public var descriptionHTML: String? { description }
    
    enum CodingKeys: String, CodingKey {
        case audiobookID = "audiobook_id"
        case name
        case authorName = "author_name"
        case description
        case avatarURLString = "avatar_url"
        case duration, language
        case releaseDate = "release_date"
        case score
    }
}

public struct AudioArticle: MediaItem, Codable, Equatable, Sendable {
    public let articleID: String
    public let name: String
    public let authorName: String?
    public let description: String?
    public let avatarURLString: String?
    public let duration: TimeInterval?
    public let releaseDate: String?
    public let score: Double?
    
    public var id: String { articleID }
    public var avatarURL: URL? { URL(string: avatarURLString ?? "") }
    public var descriptionHTML: String? { description }
    
    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case name
        case authorName = "author_name"
        case description
        case avatarURLString = "avatar_url"
        case duration
        case releaseDate = "release_date"
        case score
    }
}

public enum SectionItems: Equatable, Sendable {
    case podcasts([Podcast])
    case episodes([Episode])
    case audioBooks([AudioBook])
    case audioArticles([AudioArticle])
    
    public var count: Int {
        switch self {
        case .podcasts(let a): return a.count
        case .episodes(let a): return a.count
        case .audioBooks(let a): return a.count
        case .audioArticles(let a): return a.count
        }
    }
}

public struct Section: Codable, Equatable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let type: SectionLayout
    public let contentType: MediaKind
    public let order: Int
    public let content: SectionItems
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case contentType = "content_type"
        case order
        case content
    }
    
    public init(
        id: String = UUID().uuidString,
        name: String,
        type: SectionLayout,
        contentType: MediaKind,
        order: Int,
        content: SectionItems
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.contentType = contentType
        self.order = order
        self.content = content
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(contentType, forKey: .contentType)
        try container.encode(order, forKey: .order)

        switch content {
        case .podcasts(let podcasts):
            try container.encode(podcasts, forKey: .content)
        case .episodes(let episodes):
            try container.encode(episodes, forKey: .content)
        case .audioBooks(let books):
            try container.encode(books, forKey: .content)
        case .audioArticles(let articles):
            try container.encode(articles, forKey: .content)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try c.decode(String.self, forKey: .name)
        self.type = try c.decode(SectionLayout.self, forKey: .type)
        self.contentType = try c.decode(MediaKind.self, forKey: .contentType)
        self.order = try c.decode(Int.self, forKey: .order)
        self.id = UUID().uuidString
        switch contentType {
        case .podcast:
            let value = try c.decode([Podcast].self, forKey: .content)
            self.content = .podcasts(value)
        case .episode:
            let value = try c.decode([Episode].self, forKey: .content)
            self.content = .episodes(value)
        case .audio_book:
            let value = try c.decode([AudioBook].self, forKey: .content)
            self.content = .audioBooks(value)
        case .audio_article:
            let value = try c.decode([AudioArticle].self, forKey: .content)
            self.content = .audioArticles(value)
        }
    }
}

