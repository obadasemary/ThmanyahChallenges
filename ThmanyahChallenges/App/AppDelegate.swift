//
//  AppDelegate.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import UIKit
import ThmanyahNetworkLayer
import ThmanyahCoreAPI
import ThmanyahRepository
import ThmanyahUseCase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var composition: AppComposition!
    
    // Builders
    var homeFeedBuilder: HomeFeedBuilder!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        // Setup DI container
        composition = AppComposition()
        
        // Register builders
        homeFeedBuilder = HomeFeedBuilder(container: composition.container)
        
        return true
    }
}
