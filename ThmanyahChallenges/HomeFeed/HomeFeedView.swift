//
//  HomeFeedView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import SwiftUI
import ThmanyahUseCase

// MARK: - HomeFeedView
struct HomeFeedView: View {
    
    @State var viewModel: HomeFeedViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(Array(viewModel.sections.enumerated()), id: \.1.id) { index, section in
                        SectionView(section: section)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Discover")
            .task {
                await viewModel.refresh()
            }
            .overlay {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .padding(.bottom, 16)
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity,
                                alignment: .center
                            )
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let container = DevPreview.shared.container
    let homeFeedBuilder = HomeFeedBuilder(container: container)
    return homeFeedBuilder.buildHomeFeedView()
        .previewEnvironment()
}
