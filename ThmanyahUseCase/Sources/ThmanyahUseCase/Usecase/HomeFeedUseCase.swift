//
//  HomeFeedUseCase.swift
//  ThmanyahUseCase
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation

public protocol HomeFeedUseCaseProtocol {
    func execute(page: Int) async throws -> HomeSectionsResponse
}

public final class HomeFeedUseCase {
    
    private let homeFeedRepository: HomeFeedRepositoryProtocol
    
    public init(homeFeedRepository: HomeFeedRepositoryProtocol) {
        self.homeFeedRepository = homeFeedRepository
    }
}

extension HomeFeedUseCase: HomeFeedUseCaseProtocol {
    public func execute(page: Int) async throws -> HomeSectionsResponse {
        var response = try await homeFeedRepository.fetchSections(page: page)
        response = dedup(response)
        return response
    }
}

private extension HomeFeedUseCase {
    
    func dedup(_ res: HomeSectionsResponse) -> HomeSectionsResponse {
        let newSections: [Section] = res.sections.map { s in
            switch s.content {
            case .podcasts(let arr):
                let dict = Dictionary(grouping: arr, by: { $0.id })
                let unique = dict.compactMap { $0.value.first }
                return Section(
                    name: s.name,
                    type: s.type,
                    contentType: s.contentType,
                    order: s.order,
                    content: .podcasts(unique)
                )
            case .episodes(let arr):
                let dict = Dictionary(grouping: arr, by: { $0.id })
                let unique = dict.compactMap { $0.value.first }
                return Section(
                    name: s.name,
                    type: s.type,
                    contentType: s.contentType,
                    order: s.order,
                    content: .episodes(unique)
                )
            case .audioBooks(let arr):
                let dict = Dictionary(grouping: arr, by: { $0.id })
                let unique = dict.compactMap { $0.value.first }
                return Section(
                    name: s.name,
                    type: s.type,
                    contentType: s.contentType,
                    order: s.order,
                    content: .audioBooks(unique)
                )
            case .audioArticles(let arr):
                let dict = Dictionary(grouping: arr, by: { $0.id })
                let unique = dict.compactMap { $0.value.first }
                return Section(
                    name: s.name,
                    type: s.type,
                    contentType: s.contentType,
                    order: s.order,
                    content: .audioArticles(unique)
                )
            }
        }
        return HomeSectionsResponse(sections: newSections.sorted { $0.order < $1.order }, pagination: res.pagination)
    }
}
