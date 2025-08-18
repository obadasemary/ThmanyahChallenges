//
//  EpisodeTwoLineRow.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

public struct EpisodeTwoLineRow: View {
    
    public let episode: Episode
    
    public var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: episode.avatarURL) { phase in
                if case .success(let img) = phase {
                    img.resizable().scaledToFill()
                } else {
                    Color.secondary.opacity(0.2)
                }
            }
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(episode.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(minHeight: 36, alignment: .top) // Ensure consistent height for 2 lines
                    .frame(maxWidth: .infinity, alignment: .leading) // Use full available width
                
                HStack {
                    Text(episode.podcastName ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if let d = episode.duration {
                        Text(d.mmss)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Spacer()
            Image(systemName: "play.circle.fill")
                .font(.title3)
                .foregroundStyle(.blue)
        }
        .frame(height: 80) // Fixed height for consistent row spacing
        .padding(.horizontal, 4) // Add small horizontal padding for better edge spacing
    }
}
