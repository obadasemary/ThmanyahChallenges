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
        await loadMoreIfNeeded(currentIndex: 0)
    }

    func loadMoreIfNeeded(currentIndex: Int) async {
        guard !isLoading, currentIndex >= results.count - 3 else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let res = try await searchUseCase.execute(term: currentTerm)
            results.append(contentsOf: res.results)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


