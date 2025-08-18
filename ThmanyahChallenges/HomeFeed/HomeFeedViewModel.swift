//
//  HomeFeedViewModel.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import ThmanyahUseCase

typealias FeedSection = ThmanyahUseCase.Section

@Observable
@MainActor
class HomeFeedViewModel {
    
    private let homeFeedUseCase: HomeFeedUseCaseProtocol
    
    private(set) var sections: [FeedSection] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    private(set) var nextPage: Int? = 1
    
    init(homeFeedUseCase: HomeFeedUseCaseProtocol) {
        self.homeFeedUseCase = homeFeedUseCase
    }
}

extension HomeFeedViewModel {
    
    public func loadMoreIfNeeded(currentIndex: Int) async {
        guard currentIndex >= sections.count - 3 else { return }
        await loadNextPage()
    }
    
    public func refresh() async {
        nextPage = 1
        sections.removeAll()
        await loadNextPage()
    }
    
    public func loadNextPage() async {
        guard !isLoading, let page = nextPage else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let response = try await homeFeedUseCase.execute(page: page)
            print("response.sections.count:", response.sections.count)
            sections.append(contentsOf: response.sections)
            if let path = response.pagination.nextPage,
               let pageQuery = URLComponents(string: path)?.queryItems?.first(where: { $0.name == "page" })?.value,
               let next = Int(pageQuery) {
                nextPage = next
            } else {
                nextPage = nil
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


