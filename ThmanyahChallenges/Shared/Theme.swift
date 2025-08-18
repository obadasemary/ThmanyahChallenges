//
//  Theme.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 19.08.2025.
//

import SwiftUI

// MARK: - Theme Protocol
protocol ThemeProtocol {
    var colors: ThemeColors { get }
    var typography: ThemeTypography { get }
    var spacing: ThemeSpacing { get }
    var cornerRadius: ThemeCornerRadius { get }
    var imageSize: ThemeImageSize { get }
    var viewHeight: ThemeViewHeight { get }
    var animations: ThemeAnimations { get }
}

// MARK: - Theme Colors
struct ThemeColors {
    let primary: Color
    let secondary: Color
    let accent: Color
    let background: Color
    let cardBackground: Color
    let text: Color
    let secondaryText: Color
    let border: Color
    let shadow: Color
    let success: Color
    let warning: Color
    let error: Color
    let overlay: Color
}

// MARK: - Theme Typography
struct ThemeTypography {
    let title: Font
    let headline: Font
    let subheadline: Font
    let body: Font
    let caption: Font
    let playButton: Font
    let actionButton: Font
    let displayTitle: Font
    let sectionHeader: Font
    let cardTitle: Font
    let cardSubtitle: Font
}

// MARK: - Theme Spacing
struct ThemeSpacing {
    let extraSmall: CGFloat
    let small: CGFloat
    let medium: CGFloat
    let large: CGFloat
    let huge: CGFloat
}

// MARK: - Theme Corner Radius
struct ThemeCornerRadius {
    let small: CGFloat
    let medium: CGFloat
    let large: CGFloat
    let extraLarge: CGFloat
}

// MARK: - Theme Image Size
struct ThemeImageSize {
    let small: CGSize
    let medium: CGSize
    let large: CGSize
    let extraLarge: CGSize
}

// MARK: - Theme View Height
struct ThemeViewHeight {
    let cardHeight: CGFloat
    let twoLinesGrid: CGFloat
    let bigSquare: CGFloat
}

// MARK: - Theme Animations
struct ThemeAnimations {
    let quick: Animation
    let standard: Animation
    let slow: Animation
}

// MARK: - Light Theme
struct LightTheme: ThemeProtocol {
    let colors = ThemeColors(
        primary: Color.blue,
        secondary: Color(.systemGray),
        accent: Color.orange,
        background: Color(.systemBackground),
        cardBackground: Color(.systemGray6),
        text: Color(.label),
        secondaryText: Color(.secondaryLabel),
        border: Color(.systemGray4),
        shadow: Color.black.opacity(0.1),
        success: Color.green,
        warning: Color.yellow,
        error: Color.red,
        overlay: Color.black.opacity(0.3)
    )
    
    let typography = ThemeTypography(
        title: Font.iBMPlexSansArabicBold(size: 22),
        headline: Font.iBMPlexSansArabicSemiBold(size: 17),
        subheadline: Font.iBMPlexSansArabicMedium(size: 15),
        body: Font.iBMPlexSansArabicRegular(size: 17),
        caption: Font.iBMPlexSansArabicMedium(size: 12),
        playButton: Font.iBMPlexSansArabicMedium(size: 16),
        actionButton: Font.iBMPlexSansArabicMedium(size: 16),
        displayTitle: Font.iBMPlexSansArabicBold(size: 28),
        sectionHeader: Font.iBMPlexSansArabicBold(size: 20),
        cardTitle: Font.iBMPlexSansArabicMedium(size: 16),
        cardSubtitle: Font.iBMPlexSansArabicRegular(size: 14)
    )
    
    let spacing = ThemeSpacing(
        extraSmall: 4,
        small: 8,
        medium: 16,
        large: 20,
        huge: 32
    )
    
    let cornerRadius = ThemeCornerRadius(
        small: 8,
        medium: 12,
        large: 16,
        extraLarge: 24
    )
    
    let imageSize = ThemeImageSize(
        small: CGSize(width: 80, height: 80),
        medium: CGSize(width: 120, height: 120),
        large: CGSize(width: 160, height: 160),
        extraLarge: CGSize(width: 200, height: 200)
    )
    
    let viewHeight = ThemeViewHeight(
        cardHeight: 120,
        twoLinesGrid: 240,
        bigSquare: 200
    )
    
    let animations = ThemeAnimations(
        quick: Animation.easeInOut(duration: 0.2),
        standard: Animation.easeInOut(duration: 0.3),
        slow: Animation.easeInOut(duration: 0.5)
    )
}

// MARK: - Dark Theme
struct DarkTheme: ThemeProtocol {
    let colors = ThemeColors(
        primary: Color.blue,
        secondary: Color(.systemGray2),
        accent: Color.orange,
        background: Color(.systemBackground),
        cardBackground: Color(.systemGray5),
        text: Color(.label),
        secondaryText: Color(.secondaryLabel),
        border: Color(.systemGray3),
        shadow: Color.black.opacity(0.3),
        success: Color.green,
        warning: Color.yellow,
        error: Color.red,
        overlay: Color.black.opacity(0.5)
    )
    
    let typography = ThemeTypography(
        title: Font.iBMPlexSansArabicBold(size: 22),
        headline: Font.iBMPlexSansArabicSemiBold(size: 17),
        subheadline: Font.iBMPlexSansArabicMedium(size: 15),
        body: Font.iBMPlexSansArabicRegular(size: 17),
        caption: Font.iBMPlexSansArabicMedium(size: 12),
        playButton: Font.iBMPlexSansArabicMedium(size: 16),
        actionButton: Font.iBMPlexSansArabicMedium(size: 16),
        displayTitle: Font.iBMPlexSansArabicBold(size: 28),
        sectionHeader: Font.iBMPlexSansArabicBold(size: 20),
        cardTitle: Font.iBMPlexSansArabicMedium(size: 16),
        cardSubtitle: Font.iBMPlexSansArabicRegular(size: 14)
    )
    
    let spacing = ThemeSpacing(
        extraSmall: 4,
        small: 8,
        medium: 16,
        large: 20,
        huge: 32
    )
    
    let cornerRadius = ThemeCornerRadius(
        small: 8,
        medium: 12,
        large: 16,
        extraLarge: 24
    )
    
    let imageSize = ThemeImageSize(
        small: CGSize(width: 80, height: 80),
        medium: CGSize(width: 120, height: 120),
        large: CGSize(width: 160, height: 160),
        extraLarge: CGSize(width: 200, height: 200)
    )
    
    let viewHeight = ThemeViewHeight(
        cardHeight: 120,
        twoLinesGrid: 240,
        bigSquare: 200
    )
    
    let animations = ThemeAnimations(
        quick: Animation.easeInOut(duration: 0.2),
        standard: Animation.easeInOut(duration: 0.3),
        slow: Animation.easeInOut(duration: 0.5)
    )
}

// MARK: - Theme Manager
@Observable
class ThemeManager {
    static let shared = ThemeManager()
    
    private init() {}
    
    var currentTheme: ThemeProtocol {
        get {
            let colorScheme = UITraitCollection.current.userInterfaceStyle
            switch colorScheme {
            case .dark:
                return DarkTheme()
            case .light, .unspecified:
                return LightTheme()
            @unknown default:
                return LightTheme()
            }
        }
    }
    
    var isDarkMode: Bool {
        UITraitCollection.current.userInterfaceStyle == .dark
    }
    
    func refreshTheme() {
        // Trigger a UI update by accessing a property
        _ = currentTheme
    }
}

// MARK: - Theme Environment Key
private struct ThemeKey: EnvironmentKey {
    static let defaultValue: ThemeProtocol = LightTheme()
}

extension EnvironmentValues {
    var theme: ThemeProtocol {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// MARK: - Theme View Modifier
struct ThemeViewModifier: ViewModifier {
    @State private var themeManager = ThemeManager.shared
    
    func body(content: Content) -> some View {
        content
            .environment(\.theme, themeManager.currentTheme)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                // Refresh theme when app becomes active (e.g., after system theme change)
                themeManager.refreshTheme()
            }
    }
}

// MARK: - Theme Extension for Views
extension View {
    func withTheme() -> some View {
        self.modifier(ThemeViewModifier())
    }
}
