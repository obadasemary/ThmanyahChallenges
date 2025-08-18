# Fonts Directory

This directory contains custom fonts for the ThmanyahChallenges app.

## IBM Plex Sans Arabic Fonts

The following OTF font files are included:

- `IBMPlexSansArabic-ExtraLight.otf`
- `IBMPlexSansArabic-Thin.otf`
- `IBMPlexSansArabic-Light.otf`
- `IBMPlexSansArabic-Regular.otf`
- `IBMPlexSansArabic-Text.otf`
- `IBMPlexSansArabic-Medium.otf`
- `IBMPlexSansArabic-SemiBold.otf`
- `IBMPlexSansArabic-Bold.otf`

## Font Extensions

The `Font+EXT.swift` extension provides easy access to all font variants:

### Basic Usage
```swift
Text("مرحبا بالعالم")
    .font(.ibmPlexSansArabicRegular)

Text("مرحبا بالعالم")
    .font(.ibmPlexSansArabicBold(size: 24))
```

### Predefined Sizes
```swift
// Standard sizes
.font(.ibmPlexSansArabicRegular)        // 16pt
.font(.ibmPlexSansArabicMedium)         // 16pt
.font(.ibmPlexSansArabicBold)           // 16pt

// Large sizes
.font(.ibmPlexSansArabicRegularLarge)   // 20pt
.font(.ibmPlexSansArabicBoldLarge)      // 20pt
.font(.ibmPlexSansArabicMediumLarge)    // 20pt

// Small sizes
.font(.ibmPlexSansArabicRegularSmall)   // 14pt
.font(.ibmPlexSansArabicMediumSmall)    // 14pt
.font(.ibmPlexSansArabicLightSmall)     // 14pt

// Display sizes
.font(.ibmPlexSansArabicRegularDisplay) // 28pt
.font(.ibmPlexSansArabicBoldDisplay)    // 32pt
```

### All Available Font Weights
- **ExtraLight**: `.ibmPlexSansArabicExtraLight(size:)`
- **Thin**: `.ibmPlexSansArabicThin(size:)`
- **Light**: `.ibmPlexSansArabicLight(size:)`
- **Regular**: `.ibmPlexSansArabicRegular(size:)`
- **Text**: `.ibmPlexSansArabicText(size:)`
- **Medium**: `.ibmPlexSansArabicMedium(size:)`
- **SemiBold**: `.ibmPlexSansArabicSemiBold(size:)`
- **Bold**: `.ibmPlexSansArabicBold(size:)`

## Testing

Use the `FontDemoView` to test all font variants and ensure they're working correctly in your app.

## Project Configuration

Make sure the fonts are properly configured in your project:

1. Font files are added to the project target
2. Fonts appear in "Copy Bundle Resources" build phase
3. Font names are added to Info.plist under `UIAppFonts` key
