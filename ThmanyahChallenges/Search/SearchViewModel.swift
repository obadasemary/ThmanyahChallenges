//
//  SearchViewModel.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import ThmanyahUseCase

typealias SearchResultItem = ThmanyahUseCase.SearchResult

@Observable
@MainActor
final class SearchViewModel {
    private let searchUseCase: SearchUseCaseProtocol

    private(set) var results: [SearchResultItem] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    private(set) var nextPage: Int? = nil
    private(set) var currentTerm: String = ""

    init(searchUseCase: SearchUseCaseProtocol) {
        self.searchUseCase = searchUseCase
    }
}

extension SearchViewModel {
    func search(term: String) async {
        guard !term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        currentTerm = term
        results.removeAll()
        nextPage = 1
        await loadMoreIfNeeded(currentIndex: 0)
    }

    func loadMoreIfNeeded(currentIndex: Int) async {
        guard let page = nextPage, !isLoading, currentIndex >= results.count - 3 else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let res = try await searchUseCase.execute(term: currentTerm, page: page)
            results.append(contentsOf: res.results)
            if let path = res.pagination.nextPage,
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


