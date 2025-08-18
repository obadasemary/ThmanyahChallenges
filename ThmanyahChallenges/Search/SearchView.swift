//
//  SearchView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

struct SearchView: View {
    @State private var term: String = ""
    @State private var isEditing: Bool = false
    let viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    TextField("Search...", text: $term)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.search)
                        .onSubmit {
                            Task { await viewModel.search(term: term) }
                        }
                    if viewModel.isLoading {
                        ProgressView()
                            .padding(.leading, 8)
                    }
                }
                .padding()
                
                if let message = viewModel.errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(Array(viewModel.results.enumerated()), id: \.1.id) { index, result in
                        SearchResultRow(result: result)
                            .onAppear {
                                Task { await viewModel.loadMoreIfNeeded(currentIndex: index) }
                            }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(searchUseCase: PreviewSearchUseCase()))
}

// MARK: - Preview Helpers
private final class PreviewSearchUseCase: SearchUseCaseProtocol {
    func execute(term: String, page: Int) async throws -> SearchResponse {
        return SearchResponse(results: [], pagination: Pagination(nextPage: nil, totalPages: 1))
    }
}
