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
    
    // Internal for testing, private(set) for external access
    internal private(set) var sections: [FeedSection] = []
    internal private(set) var isLoading = false
    internal private(set) var errorMessage: String?
    internal private(set) var nextPage: Int? = 1
    
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
        errorMessage = nil  // Clear any previous error message
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

// MARK: - Testing Support

#if DEBUG
extension HomeFeedViewModel {
    // Internal methods for testing only
    internal func setLoading(_ loading: Bool) {
        self.isLoading = loading
    }
    
    internal func setSections(_ sections: [FeedSection]) {
        self.sections = sections
    }
    
    internal func setNextPage(_ page: Int?) {
        self.nextPage = page
    }
    
    internal func setErrorMessage(_ message: String?) {
        self.errorMessage = message
    }
}
#endif


