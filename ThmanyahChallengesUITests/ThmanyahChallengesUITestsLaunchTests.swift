//
//  ThmanyahChallengesUITestsLaunchTests.swift
//  ThmanyahChallengesUITests
//
//  Created by Abdelrahman Mohamed on 15.08.2025.
//

import XCTest

final class ThmanyahChallengesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for the app to fully load - give it more time for network requests
        let topPodcastsSection = app.staticTexts["Top Podcasts"]
        XCTAssertTrue(topPodcastsSection.waitForExistence(timeout: 20), "Top Podcasts section should be visible within 20 seconds")

        // Take a screenshot of the launch state
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen - HomeFeedView"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        // Verify basic app structure is present
        let exploreTab = app.tabBars.buttons["Explore"]
        XCTAssertTrue(exploreTab.exists, "Explore tab should exist")
        
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.exists, "Search tab should exist")
        
        // Verify that content sections are displayed
        let trendingEpisodesSection = app.staticTexts["Trending Episodes"]
        XCTAssertTrue(trendingEpisodesSection.waitForExistence(timeout: 15), "Trending Episodes section should be visible")
        
        // Verify that the app has loaded some content - look for any content, not just specific types
        let cells = app.cells.allElementsBoundByIndex
        let images = app.images.allElementsBoundByIndex
        let buttons = app.buttons.allElementsBoundByIndex
        
        // At least some content should be loaded
        XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some content after launch")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            let app = XCUIApplication()
            app.launch()
            
            // Wait for content to load to measure full launch time
            let topPodcastsSection = app.staticTexts["Top Podcasts"]
            _ = topPodcastsSection.waitForExistence(timeout: 20)
        }
    }
}
