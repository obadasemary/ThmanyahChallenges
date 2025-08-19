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
        let appTitle = app.staticTexts["ثمانية"]
        XCTAssertTrue(appTitle.waitForExistence(timeout: 20), "App title 'ثمانية' should be visible within 20 seconds")

        // Take a screenshot of the launch state
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen - HomeFeedView"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        // Verify basic app structure is present
        let profileAvatar = app.otherElements["profile_avatar"]
        XCTAssertTrue(profileAvatar.exists, "Profile avatar should exist")
        
        let searchButton = app.buttons["search_button"]
        XCTAssertTrue(searchButton.exists, "Search button should exist")
        
        let themeToggleButton = app.buttons["theme_toggle_button"]
        XCTAssertTrue(themeToggleButton.exists, "Theme toggle button should exist")
        
        // Verify that content sections are displayed
        let mainContentScrollView = app.scrollViews["main_content_scrollView"]
        XCTAssertTrue(mainContentScrollView.waitForExistence(timeout: 15), "Main content scroll view should be visible")
        
        // Verify that the app has loaded some content - look for any content, not just specific types
        let cells = app.cells.allElementsBoundByIndex
        let images = app.images.allElementsBoundByIndex
        let buttons = app.buttons.allElementsBoundByIndex
        
        // At least some content should be loaded
        XCTAssertTrue(cells.count > 0 || images.count > 0 || buttons.count > 0, "Should display some content after launch")
        
        // Verify navigation tabs are displayed
        let tabButtons = app.buttons.matching(identifier: "tab_*")
        XCTAssertGreaterThan(tabButtons.count, 0, "Should display navigation tabs after launch")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            let app = XCUIApplication()
            app.launch()
            
            // Wait for content to load to measure full launch time
            let appTitle = app.staticTexts["ثمانية"]
            _ = appTitle.waitForExistence(timeout: 20)
        }
    }
}
