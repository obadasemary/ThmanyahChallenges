//
//  HomeFeedView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import SwiftUI
import ThmanyahUseCase
import DependencyContainer

// MARK: - HomeFeedView
struct HomeFeedView: View {
    
    @State var viewModel: HomeFeedViewModel
    @State private var selectedTab: String = "لك"
    @Environment(SearchBuilder.self) private var searchBuilder
    @Environment(\.theme) private var theme
    
    init(viewModel: HomeFeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Header and Navigation Tabs
                TopNavigationTabs(selectedTab: $selectedTab)
                
                // Main Content
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: theme.spacing.huge) {
                        ForEach(Array(viewModel.sections.enumerated()), id: \.1.id) { index, section in
                            EnhancedSectionView(section: section)
                        }
                    }
                    .padding(.horizontal, theme.spacing.extraSmall)
                    .padding(.vertical, theme.spacing.medium)
                }
                .background(theme.colors.background)
            }
            .background(theme.colors.background)
        }
        .onFirstTask {
            await viewModel.refresh()
        }
    }
}

// MARK: - TopNavigationTabs
private struct TopNavigationTabs: View {
    @Binding var selectedTab: String
    @Environment(\.theme) private var theme
    
    private let tabs = ["لك", "البودكاست", "المقالات الصوتية", "الكتب"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Header Section
            TopHeaderSection()
            
            // Navigation Tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: theme.spacing.medium) {
                    ForEach(tabs, id: \.self) { tab in
                        TabButton(
                            title: tab,
                            isSelected: selectedTab == tab
                        ) {
                            selectedTab = tab
                        }
                    }
                }
                .padding(.horizontal, theme.spacing.large)
            }
            .padding(.vertical, theme.spacing.medium)
            .accessibilityIdentifier("main_content_scrollView")
        }
    }
}

// MARK: - TopHeaderSection
private struct TopHeaderSection: View {
    
    @Environment(SearchBuilder.self) private var searchBuilder
    @Environment(\.theme) private var theme
    
    var body: some View {
        HStack {
            // Profile/Avatar placeholder
            Circle()
                .fill(theme.colors.cardBackground)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(theme.colors.secondaryText)
                )
                .accessibilityIdentifier("profile_avatar")
            
            Spacer()
            
            // App title or logo
            Text("ثمانية")
                .font(theme.typography.title)
                .foregroundColor(theme.colors.text)
                .accessibilityIdentifier("app_title")
            
            Spacer()
            
            // Theme toggle button
            ThemeToggleButton()
            
            // Search navigation
            NavigationLink(destination: searchBuilder.buildSearchView()) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(theme.colors.text)
                    .frame(width: 40, height: 40)
                    .background(theme.colors.cardBackground)
                    .clipShape(Circle())
            }
            .accessibilityIdentifier("search_button")
            .accessibilityLabel("Search")
        }
        .padding(.horizontal, theme.spacing.large)
        .padding(.vertical, theme.spacing.medium)
        .background(theme.colors.background)
    }
}

// MARK: - TabButton
private struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    @Environment(\.theme) private var theme
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(theme.typography.subheadline)
                .foregroundColor(theme.colors.text)
                .padding(.horizontal, theme.spacing.large)
                .padding(.vertical, theme.spacing.small)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius.extraLarge, style: .continuous))
        }
        .buttonStyle(PlainButtonStyle())
        .animation(theme.animations.quick, value: isSelected)
        .accessibilityIdentifier("tab_\(title)")
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
    
    private var backgroundColor: Color {
        isSelected ? theme.colors.accent : theme.colors.cardBackground
    }
}

// MARK: - Preview
#Preview {
    let container = DevPreview.shared.container
    let homeFeedBuilder = HomeFeedBuilder(container: container)
    return homeFeedBuilder.buildHomeFeedView()
        .previewEnvironment()
        .withTheme()
}
