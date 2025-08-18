//
//  UIConstants.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI

// MARK: - UIConstants
struct UIConstants {
    
    // MARK: - Spacing
    struct Spacing {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 20
        static let huge: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 24
    }
    
    // MARK: - Image Sizes
    struct ImageSize {
        static let small = CGSize(width: 80, height: 80)
        static let medium = CGSize(width: 120, height: 120)
        static let large = CGSize(width: 160, height: 160)
        static let extraLarge = CGSize(width: 200, height: 200)
    }
    
    // MARK: - View Heights
    struct ViewHeight {
        static let cardHeight: CGFloat = 120
        static let twoLinesGrid: CGFloat = 240
        static let bigSquare: CGFloat = 200
    }
    
    // MARK: - Animations
    struct Animations {
        static let quick = Animation.easeInOut(duration: 0.2)
        static let standard = Animation.easeInOut(duration: 0.3)
        static let slow = Animation.easeInOut(duration: 0.5)
    }
    
    // MARK: - Colors
    struct Colors {
        static let primary = Color.blue
        static let secondary = Color(.systemGray)
        static let accent = Color.orange
        static let background = Color(.systemBackground)
        static let cardBackground = Color(.systemGray6)
        static let text = Color(.label)
        static let secondaryText = Color(.secondaryLabel)
    }
    
    // MARK: - Typography with IBM Plex Sans Arabic Fonts
    struct Typography {
        // Title fonts
        static let title = Font.iBMPlexSansArabicBold(size: 22)
        static let headline = Font.iBMPlexSansArabicSemiBold(size: 17)
        static let subheadline = Font.iBMPlexSansArabicMedium(size: 15)
        static let body = Font.iBMPlexSansArabicRegular(size: 17)
        static let caption = Font.iBMPlexSansArabicMedium(size: 12)
        
        // Button fonts
        static let playButton = Font.iBMPlexSansArabicMedium(size: 16)
        static let actionButton = Font.iBMPlexSansArabicMedium(size: 16)
        
        // Special fonts
        static let displayTitle = Font.iBMPlexSansArabicBold(size: 28)
        static let sectionHeader = Font.iBMPlexSansArabicBold(size: 20)
        static let cardTitle = Font.iBMPlexSansArabicMedium(size: 16)
        static let cardSubtitle = Font.iBMPlexSansArabicRegular(size: 14)
    }
}
