//
//  HomeFeedEndpointTests.swift
//  ThmanyahCoreAPI
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Testing
import Foundation
@testable import ThmanyahCoreAPI

struct HomeFeedEndpointTests {
    
    @Test("baseURL is correct")
    func testBaseURL() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        #expect(sut.baseURL == "https://api-v2-b2sit6oh3a-uc.a.run.app")
    }
    
    @Test("path without pagination")
    func testPathWithoutPagination() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        #expect(sut.path == "home_sections")
    }
    
    @Test("path with pagination")
    func testPathWithPagination() {
        let sut = HomeFeedEndpoint.getHomeSections(page: 2)
        #expect(sut.path == "home_sections?page=2")
    }
    
    @Test("HTTP method is GET")
    func testHTTPMethod() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        #expect(sut.method == .get)
    }
    
    @Test("headers use default from Endpoint extension")
    func testHeaders() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        // From Endpoint default: ["Content-Type": contentType]
        #expect(sut.headers["Content-Type"] == "application/json")
        #expect(sut.headers.count == 1)
    }
    
    @Test("parameters are nil for GET")
    func testParameters() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        #expect(sut.parameters == nil)
    }
    
    @Test("contentType is application/json")
    func testContentType() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        #expect(sut.contentType == "application/json")
    }
    
    @Test("composed URL sanity (no double slashes)")
    func testComposedURLSanity() throws {
        let sut = HomeFeedEndpoint.getHomeSections(page: 1)
        // This mirrors typical URL building logic: baseURL + "/" + path
        let urlString = "\(sut.baseURL)/\(sut.path)"
        // Ensure no accidental '//' in the middle & valid URL
        #expect(!urlString.contains("//home_sections"))
        #expect(URL(string: urlString) != nil)
    }
}
