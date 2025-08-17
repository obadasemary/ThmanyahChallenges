//
//  HomeFeedRepositoryProtocol.swift
//  ThmanyahUseCase
//
//  Created by Abdelrahman Mohamed on 17.08.2025.
//

import Foundation

public protocol HomeFeedRepositoryProtocol {
    func fetchSections(page: Int) async throws -> HomeSectionsResponse
}
