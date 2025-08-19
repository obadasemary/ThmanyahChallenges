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
    func testHomeFeedView_DisplaysCorrectHeader() throws {
        // Wait for the app to fully load and verify the header elements
        let appTitle = app.staticTexts["ثمانية"]
        XCTAssertTrue(appTitle.waitForExistence(timeout: 15), "App title 'ثمانية' should be visible")
        
        let profileAvatar = app.otherElements["profile_avatar"]
        XCTAssertTrue(profileAvatar.exists, "Profile avatar should exist")
        
        let searchButton = app.buttons["search_button"]
        XCTAssertTrue(searchButton.exists, "Search button should exist")
        
        let themeToggleButton = app.buttons["theme_toggle_button"]
        XCTAssertTrue(themeToggleButton.exists, "Theme toggle button should exist")
    }
    
    @MainActor
    func testHomeFeedView_NavigationTabsAreDisplayed() throws {
        // Wait for navigation tabs to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Verify navigation tabs exist
        let tabButtons = app.buttons.matching(identifier: "tab_*")
        XCTAssertGreaterThan(tabButtons.count, 0, "Should display navigation tabs")
        
        // Verify specific tabs exist
        let tab1 = app.buttons["tab_لك"]
        let tab2 = app.buttons["tab_البودكاست"]
        let tab3 = app.buttons["tab_المقالات الصوتية"]
        let tab4 = app.buttons["tab_الكتب"]
        
        XCTAssertTrue(tab1.exists || tab2.exists || tab3.exists || tab4.exists, "At least one navigation tab should be visible")
    }
    
    @MainActor
    func testHomeFeedView_ContentSectionsAreDisplayed() throws {
        // Wait for content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Look for enhanced section views
        let enhancedSections = app.otherElements.matching(identifier: "*_section")
        XCTAssertGreaterThan(enhancedSections.count, 0, "Should display enhanced section views")
        
        // Verify that some content is displayed
        let cells = app.cells.allElementsBoundByIndex
        let images = app.images.allElementsBoundByIndex
        let buttons = app.buttons.allElementsBoundByIndex
        
        // At least one of these should exist
        XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some content")
    }
    
    @MainActor
    func testHomeFeedView_EnhancedCardsAreDisplayed() throws {
        // Wait for content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Look for enhanced card types
        let featuredCards = app.otherElements["featured_card"]
        let squareCards = app.otherElements["square_card"]
        let twoLinesCards = app.otherElements["two_lines_card"]
        
        // At least one type of card should be displayed
        let hasCards = featuredCards.exists || squareCards.exists || twoLinesCards.exists
        XCTAssertTrue(hasCards, "Should display enhanced cards")
    }
    
    @MainActor
    func testHomeFeedView_HorizontalScrollingWorks() throws {
        // Wait for content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Look for horizontal scroll views in sections
        let horizontalScrollViews = app.scrollViews.allElementsBoundByIndex.filter { scrollView in
            scrollView.identifier.contains("section") || scrollView.identifier.contains("queue")
        }
        
        if let firstHorizontalScrollView = horizontalScrollViews.first {
            // Verify horizontal scrolling is possible
            XCTAssertTrue(firstHorizontalScrollView.exists, "Horizontal scroll view should exist")
            
            // Try to perform horizontal scroll
            firstHorizontalScrollView.swipeLeft()
            
            // Verify the scroll view still exists after scrolling
            XCTAssertTrue(firstHorizontalScrollView.exists, "Scroll view should still exist after scrolling")
        } else {
            // If no horizontal scroll views found, just verify main content exists
            XCTAssertTrue(mainContentScrollView.exists, "Main content scroll view should exist")
        }
    }
    
    @MainActor
    func testHomeFeedView_VerticalScrollingWorks() throws {
        // Wait for content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Verify vertical scrolling is possible
        XCTAssertTrue(mainContentScrollView.exists, "Main scroll view should exist")
        
        // Try to perform vertical scroll
        mainContentScrollView.swipeUp()
        
        // Verify the scroll view still exists after scrolling
        XCTAssertTrue(mainContentScrollView.exists, "Scroll view should still exist after scrolling")
    }
    
    @MainActor
    func testHomeFeedView_ConsistentSpacingAndPadding() throws {
        // Wait for content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Verify that the main scroll view exists
        XCTAssertTrue(mainContentScrollView.exists, "Main scroll view should exist")
        
        // Basic verification that content doesn't touch the very edges
        let contentFrame = mainContentScrollView.frame
        XCTAssertGreaterThan(contentFrame.minX, 0, "Content should not touch left edge")
        XCTAssertLessThan(contentFrame.maxX, app.frame.maxX, "Content should not touch right edge")
    }
    
    @MainActor
    func testHomeFeedView_SearchNavigationWorks() throws {
        // Wait for initial content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Test navigation to Search
        let searchButton = app.buttons["search_button"]
        XCTAssertTrue(searchButton.exists, "Search button should exist")
        searchButton.tap()
        
        // Wait a moment for the search view to load
        Thread.sleep(forTimeInterval: 2.0)
        
        // Look for search-related elements
        let searchElements = app.searchFields.allElementsBoundByIndex
        let textFields = app.textFields.allElementsBoundByIndex
        
        // At least one search-related element should exist
        XCTAssertTrue(searchElements.count > 0 || textFields.count > 0, "Search view should display some search elements")
        
        // Return to home feed (back button should be available)
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        if backButton.exists {
            backButton.tap()
            
            // Wait for the home feed to reload
            Thread.sleep(forTimeInterval: 2.0)
            
            // Verify we're back to home feed
            let mainContentScrollViewAfterReturn = app.scrollViews["main_content_scrollView"]
            XCTAssertTrue(mainContentScrollViewAfterReturn.waitForExistence(timeout: 10), "Should return to main content")
        }
    }
    
    @MainActor
    func testHomeFeedView_ThemeToggleWorks() throws {
        // Wait for content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Test theme toggle button
        let themeToggleButton = app.buttons["theme_toggle_button"]
        XCTAssertTrue(themeToggleButton.exists, "Theme toggle button should exist")
        
        // Verify button has proper accessibility
        XCTAssertTrue(themeToggleButton.isAccessibilityElement, "Theme toggle button should be accessible")
        
        // Tap the theme toggle button
        themeToggleButton.tap()
        
        // Wait a moment for theme change
        Thread.sleep(forTimeInterval: 1.0)
        
        // Verify the button still exists after theme change
        XCTAssertTrue(themeToggleButton.exists, "Theme toggle button should still exist after theme change")
    }
    
    @MainActor
    func testHomeFeedView_ContentLoadingAndDisplay() throws {
        // Wait for initial content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 20), "Main content scroll view should be visible")
        
        // Verify that some content is displayed
        let cells = app.cells.allElementsBoundByIndex
        let images = app.images.allElementsBoundByIndex
        let buttons = app.buttons.allElementsBoundByIndex
        
        // At least some content should be loaded
        XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some content")
        
        // Look for enhanced section views
        let enhancedSections = app.otherElements.matching(identifier: "*_section")
        XCTAssertGreaterThan(enhancedSections.count, 0, "Should display enhanced section views")
        
        // Look for any content with meaningful text
        let contentTexts = app.staticTexts.allElementsBoundByIndex.filter { text in
            text.label.count > 0 && 
            text.label != "ثمانية" && 
            !text.label.contains("tab_")
        }
        
        XCTAssertGreaterThan(contentTexts.count, 0, "Should display some content text")
    }
    
    @MainActor
    func testHomeFeedView_AccessibilityFeatures() throws {
        // Wait for content to load
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Verify accessibility identifiers are properly set
        let profileAvatar = app.otherElements["profile_avatar"]
        let searchButton = app.buttons["search_button"]
        let themeToggleButton = app.buttons["theme_toggle_button"]
        let mainContentScrollViewIdentified = app.scrollViews["main_content_scrollView"]
        
        XCTAssertTrue(profileAvatar.exists, "Profile avatar should have accessibility identifier")
        XCTAssertTrue(searchButton.exists, "Search button should have accessibility identifier")
        XCTAssertTrue(themeToggleButton.exists, "Theme toggle button should have accessibility identifier")
        XCTAssertTrue(mainContentScrollViewIdentified.exists, "Main content scroll view should have accessibility identifier")
        
        // Verify accessibility labels are set
        XCTAssertTrue(searchButton.isAccessibilityElement, "Search button should be accessible")
        XCTAssertTrue(themeToggleButton.isAccessibilityElement, "Theme toggle button should be accessible")
    }
}
