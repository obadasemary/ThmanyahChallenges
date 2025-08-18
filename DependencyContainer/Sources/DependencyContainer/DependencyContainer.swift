//
//  DependencyContainer.swift
//  DependencyContainer
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import Observation

@Observable
@MainActor
public final class DIContainer {
    
    private var services: [String: Any] = [:]
    
    public init() {}
    
    public func register<T>(_ service: T.Type, _ implementation: T) {
        let serviceName = String(describing: service)
        services[serviceName] = implementation
    }
    
    public func register<T>(_ service: T.Type, _ implementation: () -> T) {
        let serviceName = String(describing: service)
        services[serviceName] = implementation()
    }
    
    public func resolve<T>(_ service: T.Type) -> T? {
        let serviceName = String(describing: service)
        return services[serviceName] as? T
    }
}
