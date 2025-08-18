# Info.plist Configuration for IBM Plex Sans Arabic Fonts

## Required Info.plist Entry

Add this to your project's Info.plist or project configuration:

```xml
<key>UIAppFonts</key>
<array>
    <string>IBMPlexSansArabic-ExtraLight.otf</string>
    <string>IBMPlexSansArabic-Thin.otf</string>
    <string>IBMPlexSansArabic-Light.otf</string>
    <string>IBMPlexSansArabic-Regular.otf</string>
    <string>IBMPlexSansArabic-Text.otf</string>
    <string>IBMPlexSansArabic-Medium.otf</string>
    <string>IBMPlexSansArabic-SemiBold.otf</string>
    <string>IBMPlexSansArabic-Bold.otf</string>
</array>
```

## Xcode Project Configuration

Since your project uses `GENERATE_INFOPLIST_FILE = YES`, you need to add this to your project configuration:

1. **In Xcode:**
   - Select your project
   - Select your main app target
   - Go to "Info" tab
   - Add a new key: `Fonts provided by application` (UIAppFonts)
   - Add each font filename as a separate item

2. **Alternative: Add to project.pbxproj**
   - Open `ThmanyahChallenges.xcodeproj/project.pbxproj`
   - Find your main target section
   - Add the font files to the `INFOPLIST_KEY_UIAppFonts` array

## Verification Steps

1. **Build Phases:**
   - Ensure all OTF files are in "Copy Bundle Resources"
   - Verify target membership is correct

2. **Font Loading:**
   - Use `FontDemoView` to test all fonts
   - Check Xcode console for font loading errors

3. **Runtime Verification:**
   - The fonts should be available immediately after app launch
   - No additional setup code required
