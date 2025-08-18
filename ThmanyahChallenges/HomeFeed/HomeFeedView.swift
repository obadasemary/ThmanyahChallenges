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
    @State private var selectedTab: String = "لك"
    @Environment(SearchBuilder.self) private var searchBuilder
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Header and Navigation Tabs
                TopNavigationTabs(selectedTab: $selectedTab)
                
                // Main Content
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 32) {
                        ForEach(Array(viewModel.sections.enumerated()), id: \.1.id) { index, section in
                            EnhancedSectionView(section: section)
                        }
                    }
                    .padding(.vertical, 20)
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
            .onFirstTask {
                await viewModel.refresh()
            }
        }
    }
}

// MARK: - TopNavigationTabs
private struct TopNavigationTabs: View {
    
    @Binding var selectedTab: String
    @Environment(SearchBuilder.self) private var searchBuilder
    
    private let tabs = ["لك", "البودكاست", "المقالات الصوتية", "الكتب"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Header Section
            TopHeaderSection()
            
            // Navigation Tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: UIConstants.Spacing.medium) {
                    ForEach(tabs, id: \.self) { tab in
                        TabButton(
                            title: tab,
                            isSelected: selectedTab == tab
                        ) {
                            selectedTab = tab
                        }
                    }
                }
                .padding(.horizontal, UIConstants.Spacing.large)
            }
            .padding(.vertical, UIConstants.Spacing.medium)
            .accessibilityIdentifier("main_content_scrollView")
        }
    }
}

// MARK: - TopHeaderSection
private struct TopHeaderSection: View {
    
    @Environment(SearchBuilder.self) private var searchBuilder
    
    var body: some View {
        HStack {
            // Profile/Avatar placeholder
            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.secondary)
                )
                .accessibilityIdentifier("profile_avatar")
            
            Spacer()
            
            // App title or logo
            Text("ثمانية")
                .font(UIConstants.Typography.title)
                .foregroundColor(.primary)
                .accessibilityIdentifier("app_title")
            
            Spacer()
            
            // Search navigation
            NavigationLink(destination: searchBuilder.buildSearchView()) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
            .accessibilityIdentifier("search_button")
            .accessibilityLabel("Search")
        }
        .padding(.horizontal, UIConstants.Spacing.large)
        .padding(.vertical, UIConstants.Spacing.medium)
        .background(Color(.systemBackground))
    }
}

// MARK: - TabButton
private struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(UIConstants.Typography.subheadline)
                .foregroundColor(.primary)
                .padding(.horizontal, UIConstants.Spacing.large)
                .padding(.vertical, UIConstants.Spacing.small)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: UIConstants.CornerRadius.extraLarge, style: .continuous))
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: isSelected)
        .accessibilityIdentifier("tab_\(title)")
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
    
    private var backgroundColor: Color {
        isSelected ? Color.red : Color(.systemGray5)
    }
}

// MARK: - Preview
#Preview {
    let container = DevPreview.shared.container
    let homeFeedBuilder = HomeFeedBuilder(container: container)
    return homeFeedBuilder.buildHomeFeedView()
        .previewEnvironment()
}
