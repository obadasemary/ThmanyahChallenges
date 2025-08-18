//
//  TimeInterval+EXT.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation

public extension TimeInterval {
    var mmss: String {
        let total = Int(self)
        return String(format: "%d:%02d", total / 60, total % 60)
    }
}
