//
//  MediaCardSquare.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

public struct MediaCardSquare<Item: MediaItem>: View {
    
    public let item: Item
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: item.avatarURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure(_):
                    Color.secondary.opacity(0.2)
                case .empty:
                    ProgressView()
                @unknown default:
                    Color.gray
                }
            }
            .frame(width: 140, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(item.name)
                .font(.headline)
                .lineLimit(2)
                .frame(
                    minHeight: 44,
                    alignment: .topLeading
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let duration = item.duration {
                Text(duration.mmss)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 160)
    }
}
