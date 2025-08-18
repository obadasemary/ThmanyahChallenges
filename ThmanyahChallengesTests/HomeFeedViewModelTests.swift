//
//  HomeFeedViewModelTests.swift
//  ThmanyahChallengesTests
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import XCTest
import Testing
@testable import ThmanyahChallenges
@testable import ThmanyahUseCase

@MainActor
struct HomeFeedViewModelTests {
    
    // MARK: - Test Setup
    
    @Test("initial state is correct")
    func testInitialState() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        #expect(sut.sections.isEmpty)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        #expect(sut.nextPage == 1)
    }
    
    // MARK: - Load Next Page Tests
    
    @Test("loadNextPage loads first page successfully")
    func testLoadNextPageLoadsFirstPage() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Setup mock response
        let mockSections = createMockSections(count: 3)
        let mockResponse = HomeSectionsResponse(
            sections: mockSections,
            pagination: Pagination(nextPage: "?page=2", totalPages: 5)
        )
        mockUseCase.mockResponse = mockResponse
        
        await sut.loadNextPage()
        
        #expect(sut.sections.count == 3)
        #expect(sut.nextPage == 2)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
    }
    
    @Test("loadNextPage handles empty response")
    func testLoadNextPageHandlesEmptyResponse() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Setup mock empty response
        let mockResponse = HomeSectionsResponse(
            sections: [],
            pagination: Pagination(nextPage: nil, totalPages: 1)
        )
        mockUseCase.mockResponse = mockResponse
        
        await sut.loadNextPage()
        
        #expect(sut.sections.isEmpty)
        #expect(sut.nextPage == nil)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
    }
    
    @Test("loadNextPage handles error")
    func testLoadNextPageHandlesError() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Setup mock error
        mockUseCase.mockError = NetworkError.serverError(statusCode: 500)
        
        await sut.loadNextPage()
        
        #expect(sut.sections.isEmpty)
        #expect(sut.nextPage == 1) // Should remain unchanged
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage != nil)
        #expect(sut.errorMessage?.contains("500") == true)
    }
    
    @Test("loadNextPage does not load when already loading")
    func testLoadNextPageDoesNotLoadWhenAlreadyLoading() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Set loading state
        sut.setLoading(true)
        
        await sut.loadNextPage()
        
        #expect(sut.sections.isEmpty) // Should not have loaded any sections
        #expect(mockUseCase.executeCallCount == 0) // Should not have called use case
    }
    
    @Test("loadNextPage does not load when no next page")
    func testLoadNextPageDoesNotLoadWhenNoNextPage() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Set no next page
        sut.setNextPage(nil)
        
        await sut.loadNextPage()
        
        #expect(sut.sections.isEmpty) // Should not have loaded any sections
        #expect(mockUseCase.executeCallCount == 0) // Should not have called use case
    }
    
    @Test("loadNextPage appends sections to existing ones")
    func testLoadNextPageAppendsSections() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Load first page
        let firstPageSections = createMockSections(count: 2)
        let firstPageResponse = HomeSectionsResponse(
            sections: firstPageSections,
            pagination: Pagination(nextPage: "?page=2", totalPages: 3)
        )
        mockUseCase.mockResponse = firstPageResponse
        
        await sut.loadNextPage()
        #expect(sut.sections.count == 2)
        
        // Load second page
        let secondPageSections = createMockSections(count: 1)
        let secondPageResponse = HomeSectionsResponse(
            sections: secondPageSections,
            pagination: Pagination(nextPage: nil, totalPages: 3)
        )
        mockUseCase.mockResponse = secondPageResponse
        
        await sut.loadNextPage()
        
        #expect(sut.sections.count == 3) // Should have 2 + 1 sections
        #expect(sut.nextPage == nil) // No more pages
    }
    
    // MARK: - Load More If Needed Tests
    
    @Test("loadMoreIfNeeded loads when near end")
    func testLoadMoreIfNeededLoadsWhenNearEnd() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Add some sections first
        let initialSections = createMockSections(count: 10)
        sut.setSections(initialSections)
        
        // Setup mock response for next page
        let nextPageSections = createMockSections(count: 5)
        let mockResponse = HomeSectionsResponse(
            sections: nextPageSections,
            pagination: Pagination(nextPage: nil, totalPages: 2)
        )
        mockUseCase.mockResponse = mockResponse
        
        // Call loadMoreIfNeeded when near end (within 3 items of the end)
        await sut.loadMoreIfNeeded(currentIndex: 8) // 10 - 3 = 7, so 8 should trigger load
        
        #expect(sut.sections.count == 15) // 10 + 5
        #expect(mockUseCase.executeCallCount == 1)
    }
    
    @Test("loadMoreIfNeeded does not load when not near end")
    func testLoadMoreIfNeededDoesNotLoadWhenNotNearEnd() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Add some sections
        let initialSections = createMockSections(count: 10)
        sut.setSections(initialSections)
        
        // Call loadMoreIfNeeded when not near end
        await sut.loadMoreIfNeeded(currentIndex: 5) // 10 - 3 = 7, so 5 should not trigger load
        
        #expect(sut.sections.count == 10) // Should remain unchanged
        #expect(mockUseCase.executeCallCount == 0) // Should not have called use case
    }
    
    @Test("loadMoreIfNeeded does not load when no next page")
    func testLoadMoreIfNeededDoesNotLoadWhenNoNextPage() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Set no next page
        sut.setNextPage(nil)
        
        // Add some sections
        let initialSections = createMockSections(count: 10)
        sut.setSections(initialSections)
        
        await sut.loadMoreIfNeeded(currentIndex: 8)
        
        #expect(sut.sections.count == 10) // Should remain unchanged
        #expect(mockUseCase.executeCallCount == 0) // Should not have called use case
    }
    
    // MARK: - Refresh Tests
    
    @Test("refresh resets state and loads first page")
    func testRefreshResetsStateAndLoadsFirstPage() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Add some existing sections
        let existingSections = createMockSections(count: 5)
        sut.setSections(existingSections)
        sut.setNextPage(3)
        
        // Setup mock response for refresh
        let refreshSections = createMockSections(count: 3)
        let mockResponse = HomeSectionsResponse(
            sections: refreshSections,
            pagination: Pagination(nextPage: "?page=2", totalPages: 4)
        )
        mockUseCase.mockResponse = mockResponse
        
        await sut.refresh()
        
        #expect(sut.sections.count == 3) // Should have new sections, not old + new
        #expect(sut.nextPage == 2) // Should be reset to first page then updated
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
    }
    
    @Test("refresh clears error message")
    func testRefreshClearsErrorMessage() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Set error message
        sut.setErrorMessage("Some error")
        
        // Setup mock response
        let mockResponse = HomeSectionsResponse(
            sections: [],
            pagination: Pagination(nextPage: nil, totalPages: 1)
        )
        mockUseCase.mockResponse = mockResponse
        
        await sut.refresh()
        
        #expect(sut.errorMessage == nil) // Error should be cleared
    }
    
    // MARK: - Pagination Parsing Tests
    
    @Test("pagination parsing works with valid next page")
    func testPaginationParsingWithValidNextPage() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Setup mock response with valid next page URL
        let mockResponse = HomeSectionsResponse(
            sections: createMockSections(count: 2),
            pagination: Pagination(nextPage: "https://api.example.com/home_sections?page=3&other=param", totalPages: 5)
        )
        mockUseCase.mockResponse = mockResponse
        
        await sut.loadNextPage()
        
        #expect(sut.nextPage == 3) // Should parse page=3 from URL
    }
    
    @Test("pagination parsing handles missing page parameter")
    func testPaginationParsingHandlesMissingPageParameter() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Setup mock response with next page URL but no page parameter
        let mockResponse = HomeSectionsResponse(
            sections: createMockSections(count: 2),
            pagination: Pagination(nextPage: "https://api.example.com/home_sections?other=param", totalPages: 5)
        )
        mockUseCase.mockResponse = mockResponse
        
        await sut.loadNextPage()
        
        #expect(sut.nextPage == nil) // Should be nil when no page parameter
    }
    
    @Test("pagination parsing handles invalid page parameter")
    func testPaginationParsingHandlesInvalidPageParameter() async {
        let mockUseCase = MockHomeFeedUseCase()
        let sut = HomeFeedViewModel(homeFeedUseCase: mockUseCase)
        
        // Setup mock response with invalid page parameter
        let mockResponse = HomeSectionsResponse(
            sections: createMockSections(count: 2),
            pagination: Pagination(nextPage: "https://api.example.com/home_sections?page=invalid", totalPages: 5)
        )
        mockUseCase.mockResponse = mockResponse
        
        await sut.loadNextPage()
        
        #expect(sut.nextPage == nil) // Should be nil when page parameter is not a number
    }
}

// MARK: - Mock HomeFeedUseCase

@MainActor
final class MockHomeFeedUseCase: HomeFeedUseCaseProtocol {
    var mockResponse: HomeSectionsResponse?
    var mockError: Error?
    var executeCallCount = 0
    
    func execute(page: Int) async throws -> HomeSectionsResponse {
        executeCallCount += 1
        
        if let error = mockError {
            throw error
        }
        
        guard let response = mockResponse else {
            throw NetworkError.serverError(statusCode: 500)
        }
        
        return response
    }
}

// MARK: - Mock NetworkError

enum NetworkError: Error, Equatable, LocalizedError {
    case serverError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        }
    }
}

// MARK: - Helper Methods

extension HomeFeedViewModelTests {
    
    func createMockSections(count: Int) -> [Section] {
        return (0..<count).map { index in
            Section(
                name: "Section \(index)",
                type: SectionLayout.square,
                contentType: MediaKind.podcast,
                order: index,
                content: .podcasts([
                    Podcast(
                        podcastID: "podcast_\(index)",
                        name: "Podcast \(index)",
                        description: "Description \(index)",
                        avatarURLString: "https://example.com/avatar\(index).jpg",
                        episodeCount: index + 1,
                        duration: TimeInterval(index * 60),
                        language: "en",
                        priority: index,
                        popularityScore: index * 10,
                        score: Double(index) / 10.0
                    )
                ])
            )
        }
    }
}
