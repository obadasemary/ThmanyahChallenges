//
//  ThemeToggleButton.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 19.08.2025.
//

import SwiftUI

// MARK: - ThemeToggleButton
struct ThemeToggleButton: View {
    @State private var themeManager = ThemeManager.shared
    @Environment(\.theme) private var theme
    
    var body: some View {
        Button(action: toggleTheme) {
            Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(theme.colors.text)
                .frame(width: 40, height: 40)
                .background(theme.colors.cardBackground)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(theme.colors.border, lineWidth: 1)
                )
        }
        .accessibilityIdentifier("theme_toggle_button")
        .accessibilityLabel(themeManager.isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode")
        .animation(theme.animations.quick, value: themeManager.isDarkMode)
    }
    
    private func toggleTheme() {
        // Toggle between light and dark mode
        if themeManager.isDarkMode {
            // Switch to light mode
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        } else {
            // Switch to dark mode
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        }
        
        // Trigger theme update
        themeManager.refreshTheme()
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        ThemeToggleButton()
            .withTheme()
        
        // Show both themes
        HStack(spacing: 20) {
            VStack {
                Text("Light Theme")
                    .font(.headline)
                ThemeToggleButton()
                    .withTheme()
            }
            .padding()
            .background(Color.white)
            .preferredColorScheme(.light)
            
            VStack {
                Text("Dark Theme")
                    .font(.headline)
                ThemeToggleButton()
                    .withTheme()
            }
            .padding()
            .background(Color.black)
            .preferredColorScheme(.dark)
        }
    }
    .withTheme()
}
