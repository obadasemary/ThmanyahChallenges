//
//  DependencyContainer.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation

@Observable
@MainActor
class DependencyContainer {
    
    private var services: [String: Any] = [:]
    
    func register<T>(_ service: T.Type, _ implementation: T) {
        let serviceName = String(describing: service)
        services[serviceName] = implementation
    }
    
    func register<T>(_ service: T.Type, _ implementation: () -> T) {
        let serviceName = String(describing: service)
        services[serviceName] = implementation()
    }
    
    func resolve<T>(_ service: T.Type) -> T? {
        let serviceName = String(describing: service)
        return services[serviceName] as? T
    }
}
