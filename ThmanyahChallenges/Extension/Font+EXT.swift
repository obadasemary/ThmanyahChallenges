//
//  Font+EXT.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI

public extension Font {
    
    // MARK: - IBM Plex Sans Arabic Fonts
    
    /// IBM Plex Sans Arabic ExtraLight
    static func iBMPlexSansArabicExtraLight(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-ExtraLight", size: size)
    }
    
    /// IBM Plex Sans Arabic Thin
    static func iBMPlexSansArabicThin(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-Thin", size: size)
    }
    
    /// IBM Plex Sans Arabic Light
    static func iBMPlexSansArabicLight(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-Light", size: size)
    }
    
    /// IBM Plex Sans Arabic Regular
    static func iBMPlexSansArabicRegular(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-Regular", size: size)
    }
    
    /// IBM Plex Sans Arabic Text
    static func iBMPlexSansArabicText(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-Text", size: size)
    }
    
    /// IBM Plex Sans Arabic Medium
    static func iBMPlexSansArabicMedium(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-Medium", size: size)
    }
    
    /// IBM Plex Sans Arabic SemiBold
    static func iBMPlexSansArabicSemiBold(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-SemiBold", size: size)
    }
    
    /// IBM Plex Sans Arabic Bold
    static func iBMPlexSansArabicBold(size: CGFloat) -> Font {
        return .custom("IBMPlexSansArabic-Bold", size: size)
    }
    
    // MARK: - Predefined Sizes
    
    /// IBM Plex Sans Arabic fonts with predefined sizes
    static let iBMPlexSansArabicExtraLight = Font.iBMPlexSansArabicExtraLight(size: 16)
    static let iBMPlexSansArabicThin = Font.iBMPlexSansArabicThin(size: 16)
    static let iBMPlexSansArabicLight = Font.iBMPlexSansArabicLight(size: 16)
    static let iBMPlexSansArabicRegular = Font.iBMPlexSansArabicRegular(size: 16)
    static let iBMPlexSansArabicText = Font.iBMPlexSansArabicText(size: 16)
    static let iBMPlexSansArabicMedium = Font.iBMPlexSansArabicMedium(size: 16)
    static let iBMPlexSansArabicSemiBold = Font.iBMPlexSansArabicSemiBold(size: 16)
    static let iBMPlexSansArabicBold = Font.iBMPlexSansArabicBold(size: 16)
    
    // MARK: - Large Sizes
    static let iBMPlexSansArabicRegularLarge = Font.iBMPlexSansArabicRegular(size: 20)
    static let iBMPlexSansArabicBoldLarge = Font.iBMPlexSansArabicBold(size: 20)
    static let iBMPlexSansArabicMediumLarge = Font.iBMPlexSansArabicMedium(size: 20)
    
    // MARK: - Small Sizes
    static let iBMPlexSansArabicRegularSmall = Font.iBMPlexSansArabicRegular(size: 14)
    static let iBMPlexSansArabicMediumSmall = Font.iBMPlexSansArabicMedium(size: 14)
    static let iBMPlexSansArabicLightSmall = Font.iBMPlexSansArabicLight(size: 14)
    
    // MARK: - Display Sizes
    static let iBMPlexSansArabicBoldDisplay = Font.iBMPlexSansArabicBold(size: 32)
    static let iBMPlexSansArabicRegularDisplay = Font.iBMPlexSansArabicRegular(size: 28)
}
