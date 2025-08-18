//
//  FontDemoView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI

struct FontDemoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("IBM Plex Sans Arabic Fonts Demo")
                    .font(.iBMPlexSansArabicBoldDisplay)
                    .padding(.bottom, 10)
                
                Group {
                    Text("مرحبا بالعالم - ExtraLight")
                        .font(.iBMPlexSansArabicExtraLight)
                    
                    Text("مرحبا بالعالم - Thin")
                        .font(.iBMPlexSansArabicThin)
                    
                    Text("مرحبا بالعالم - Light")
                        .font(.iBMPlexSansArabicLight)
                    
                    Text("مرحبا بالعالم - Regular")
                        .font(.iBMPlexSansArabicRegular)
                    
                    Text("مرحبا بالعالم - Text")
                        .font(.iBMPlexSansArabicText)
                    
                    Text("مرحبا بالعالم - Medium")
                        .font(.iBMPlexSansArabicMedium)
                    
                    Text("مرحبا بالعالم - SemiBold")
                        .font(.iBMPlexSansArabicSemiBold)
                    
                    Text("مرحبا بالعالم - Bold")
                        .font(.iBMPlexSansArabicBold)
                }
                
                Divider()
                
                Group {
                    Text("Custom Sizes")
                        .font(.iBMPlexSansArabicBold(size: 18))
                    
                    Text("مرحبا بالعالم - Size 24")
                        .font(.iBMPlexSansArabicRegular(size: 24))
                    
                    Text("مرحبا بالعالم - Size 12")
                        .font(.iBMPlexSansArabicMedium(size: 12))
                }
                
                Divider()
                
                Group {
                    Text("Predefined Sizes")
                        .font(.iBMPlexSansArabicBold(size: 16))
                    
                    Text("مرحبا بالعالم - Large")
                        .font(.iBMPlexSansArabicRegularLarge)
                    
                    Text("مرحبا بالعالم - Medium Large")
                        .font(.iBMPlexSansArabicMediumLarge)
                    
                    Text("مرحبا بالعالم - Small")
                        .font(.iBMPlexSansArabicRegularSmall)
                    
                    Text("مرحبا بالعالم - Light Small")
                        .font(.iBMPlexSansArabicLightSmall)
                }
                
                Divider()
                
                Group {
                    Text("Display Sizes")
                        .font(.iBMPlexSansArabicBold(size: 16))
                    
                    Text("مرحبا بالعالم - Display")
                        .font(.iBMPlexSansArabicRegularDisplay)
                    
                    Text("مرحبا بالعالم - Bold Display")
                        .font(.iBMPlexSansArabicBoldDisplay)
                }
                
                Divider()
                
                Group {
                    Text("Mixed Language Example")
                        .font(.iBMPlexSansArabicBold(size: 16))
                    
                    Text("Hello World - مرحبا بالعالم")
                        .font(.iBMPlexSansArabicRegular)
                        .multilineTextAlignment(.leading)
                }
                
                Divider()
                
                Group {
                    Text("Font Weight Comparison")
                        .font(.iBMPlexSansArabicBold(size: 16))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ExtraLight: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicExtraLight)
                        Text("Thin: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicThin)
                        Text("Light: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicLight)
                        Text("Regular: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicRegular)
                        Text("Text: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicText)
                        Text("Medium: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicMedium)
                        Text("SemiBold: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicSemiBold)
                        Text("Bold: مرحبا بالعالم")
                            .font(.iBMPlexSansArabicBold)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Font Demo")
    }
}

#Preview {
    FontDemoView()
}
