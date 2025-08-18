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
        #expect(sut.path == "/home_sections")
    }
    
    @Test("path with pagination")
    func testPathWithPagination() {
        let sut = HomeFeedEndpoint.getHomeSections(page: 2)
        // Path should only contain the path component, not query parameters
        #expect(sut.path == "/home_sections")
        // Parameters should contain the query parameters
        #expect(sut.parameters?["page"] as? Int == 2)
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
    
    @Test("parameters are nil for GET without page")
    func testParametersWithoutPage() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        #expect(sut.parameters == nil)
    }
    
    @Test("parameters contain page when provided")
    func testParametersWithPage() {
        let sut = HomeFeedEndpoint.getHomeSections(page: 2)
        #expect(sut.parameters?["page"] as? Int == 2)
    }
    
    @Test("contentType is application/json")
    func testContentType() {
        let sut = HomeFeedEndpoint.getHomeSections(page: nil)
        #expect(sut.contentType == "application/json")
    }
    
    @Test("composed URL sanity (no double slashes in path)")
    func testComposedURLSanity() throws {
        let sut = HomeFeedEndpoint.getHomeSections(page: 1)
        // This mirrors typical URL building logic: baseURL + path (path already starts with /)
        let urlString = sut.baseURL + sut.path
        // Ensure no accidental '//' in the path part (after the protocol)
        let pathPart = String(urlString.dropFirst("https://".count))
        #expect(!pathPart.contains("//"))
        #expect(URL(string: urlString) != nil)
    }
    
    @Test("full URL construction with parameters")
    func testFullURLConstruction() throws {
        let sut = HomeFeedEndpoint.getHomeSections(page: 2)
        
        // Build the full URL as the NetworkService would
        var urlComponents = URLComponents(string: sut.baseURL + sut.path)!
        if let params = sut.parameters {
            urlComponents.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        let fullURL = urlComponents.url!
        let expectedURLString = "https://api-v2-b2sit6oh3a-uc.a.run.app/home_sections?page=2"
        
        #expect(fullURL.absoluteString == expectedURLString)
    }
}
