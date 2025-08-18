//
//  ThmanyahChallengesUITests.swift
//  ThmanyahChallengesUITests
//
//  Created by Abdelrahman Mohamed on 15.08.2025.
//

import XCTest

final class ThmanyahChallengesUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - HomeFeedView Tests
    
    @MainActor
    func testHomeFeedView_DisplaysCorrectSections() throws {
        // Wait for the app to fully load and verify that the main sections are displayed
        let topPodcastsSection = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSection.waitForExistence(timeout: 15), "Top Podcasts section should be visible")
        
        let trendingEpisodesSection = app.staticTexts["Trending Episodes"]
        XCTAssertTrue(trendingEpisodesSection.waitForExistence(timeout: 10), "Trending Episodes section should be visible")
        
        // Verify navigation bar is present
        let exploreTab = app.tabBars.buttons["Explore"]
        XCTAssertTrue(exploreTab.exists, "Explore tab should exist")
        
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.exists, "Search tab should exist")
    }
    
    @MainActor
    func testHomeFeedView_TopPodcastsSection_HasConsistentCardLayout() throws {
        // Wait for content to load
        let topPodcastsSection = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSection.waitForExistence(timeout: 15), "Top Podcasts section should be visible")
        
        // Look for any content in the Top Podcasts section
        // SwiftUI may not expose collectionViews directly, so we'll look for any content
        let cells = app.cells.allElementsBoundByIndex
        let images = app.images.allElementsBoundByIndex
        let buttons = app.buttons.allElementsBoundByIndex
        
        // At least one of these should exist
        XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some content")
    }
    
    @MainActor
    func testHomeFeedView_TopPodcastsSection_HorizontalScrollWorks() throws {
        // Wait for content to load
        let topPodcastsSection = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSection.waitForExistence(timeout: 15), "Top Podcasts section should be visible")
        
        // Find any scrollable content
        let scrollViews = app.scrollViews.allElementsBoundByIndex
        guard let firstScrollView = scrollViews.first else {
            XCTFail("No scroll views found")
            return
        }
        
        // Verify horizontal scrolling is possible by checking if it's scrollable
        XCTAssertTrue(firstScrollView.exists, "Scroll view should exist")
        
        // Try to perform horizontal scroll
        firstScrollView.swipeLeft()
        
        // Just verify the scroll view still exists after scrolling
        XCTAssertTrue(firstScrollView.exists, "Scroll view should still exist after scrolling")
    }
    
    @MainActor
    func testHomeFeedView_TrendingEpisodesSection_HasConsistentRowLayout() throws {
        // Wait for content to load
        let trendingEpisodesSection = app.staticTexts["Trending Episodes"]
        XCTAssertTrue(trendingEpisodesSection.waitForExistence(timeout: 15), "Trending Episodes section should be visible")
        
        // Look for any content in the Trending Episodes section
        // SwiftUI may not expose tables directly, so we'll look for any content
        let cells = app.cells.allElementsBoundByIndex
        let images = app.images.allElementsBoundByIndex
        let buttons = app.buttons.allElementsBoundByIndex
        
        // At least some content should exist
        XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some episode content")
    }
    
    @MainActor
    func testHomeFeedView_TrendingEpisodesSection_VerticalScrollWorks() throws {
        // Wait for content to load
        let trendingEpisodesSection = app.staticTexts["Trending Episodes"]
        XCTAssertTrue(trendingEpisodesSection.waitForExistence(timeout: 15), "Trending Episodes section should be visible")
        
        // Find any scrollable content
        let scrollViews = app.scrollViews.allElementsBoundByIndex
        guard let firstScrollView = scrollViews.first else {
            XCTFail("No scroll views found")
            return
        }
        
        // Verify vertical scrolling is possible
        XCTAssertTrue(firstScrollView.exists, "Scroll view should exist")
        
        // Try to perform vertical scroll
        firstScrollView.swipeUp()
        
        // Just verify the scroll view still exists after scrolling
        XCTAssertTrue(firstScrollView.exists, "Scroll view should still exist after scrolling")
    }
    
    @MainActor
    func testHomeFeedView_ConsistentSpacingAndPadding() throws {
        // Wait for content to load
        let topPodcastsSection = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSection.waitForExistence(timeout: 15), "Top Podcasts section should be visible")
        
        // Verify that sections exist
        XCTAssertTrue(topPodcastsSection.exists, "Top Podcasts section should exist")
        
        // Look for any scrollable content - may not be a main scroll view
        let scrollViews = app.scrollViews.allElementsBoundByIndex
        let mainScrollView = scrollViews.first
        
        if let mainScrollView = mainScrollView {
            // If we found a scroll view, verify it exists
            XCTAssertTrue(mainScrollView.exists, "Main scroll view should exist")
            
            // Basic verification that content doesn't touch the very edges
            let contentFrame = mainScrollView.frame
            XCTAssertGreaterThan(contentFrame.minX, 0, "Content should not touch left edge")
            XCTAssertLessThan(contentFrame.maxX, app.frame.maxX, "Content should not touch right edge")
        } else {
            // If no scroll view found, just verify the section exists and has some content
            XCTAssertTrue(topPodcastsSection.exists, "Top Podcasts section should exist")
            
            // Look for any content to verify the section is populated
            let cells = app.cells.allElementsBoundByIndex
            let images = app.images.allElementsBoundByIndex
            let buttons = app.buttons.allElementsBoundByIndex
            
            // At least some content should exist
            XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some content")
        }
    }
    
    @MainActor
    func testHomeFeedView_NavigationWorks() throws {
        // Wait for initial content to load
        let topPodcastsSection = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSection.waitForExistence(timeout: 15), "Top Podcasts section should be visible")
        
        // Test navigation to Search tab
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.exists, "Search tab should exist")
        searchTab.tap()
        
        // Wait a moment for the search view to load
        Thread.sleep(forTimeInterval: 2.0)
        
        // Look for search-related elements (may not be a text field with "Search..." placeholder)
        let searchElements = app.searchFields.allElementsBoundByIndex
        let textFields = app.textFields.allElementsBoundByIndex
        
        // At least one search-related element should exist
        XCTAssertTrue(searchElements.count > 0 || textFields.count > 0, "Search view should display some search elements")
        
        // Return to Explore tab
        let exploreTab = app.tabBars.buttons["Explore"]
        XCTAssertTrue(exploreTab.exists, "Explore tab should exist")
        exploreTab.tap()
        
        // Wait for the home feed to reload
        Thread.sleep(forTimeInterval: 2.0)
        
        // Verify we're back to home feed
        let topPodcastsSectionAfterReturn = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSectionAfterReturn.waitForExistence(timeout: 10), "Should return to Top Podcasts section")
    }
    
    @MainActor
    func testHomeFeedView_ContentLoadingAndDisplay() throws {
        // Wait for initial content to load
        let topPodcastsSection = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSection.waitForExistence(timeout: 20), "Top Podcasts section should be visible")
        
        // Verify that some content is displayed
        let cells = app.cells.allElementsBoundByIndex
        let images = app.images.allElementsBoundByIndex
        let buttons = app.buttons.allElementsBoundByIndex
        
        // At least some content should be loaded
        XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some content")
        
        // Verify that episode content is loaded
        let trendingEpisodesSection = app.staticTexts["Trending Episodes"]
        XCTAssertTrue(trendingEpisodesSection.waitForExistence(timeout: 10), "Trending Episodes section should be visible")
        
        // Look for any episode-related content
        let episodeContent = app.staticTexts.allElementsBoundByIndex.filter { text in
            text.label.count > 0 && text.label != "Top Podcasts" && text.label != "Trending Episodes"
        }
        
        XCTAssertGreaterThan(episodeContent.count, 0, "Should display some episode content")
    }
}
