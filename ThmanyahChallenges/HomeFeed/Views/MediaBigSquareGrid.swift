//
//  MediaBigSquareGrid.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI
import ThmanyahUseCase

public struct MediaBigSquareGrid<Item: MediaItem>: View {
    
    public let items: [Item]
    
    public var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(items, id: \.id) { item in
                VStack(alignment: .leading, spacing: 8) {
                    AsyncImage(url: item.avatarURL) { phase in
                        if case .success(let img) = phase {
                            img.resizable().scaledToFill()
                        } else {
                            Color.secondary.opacity(0.2)
                        }
                    }
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    
                    Text(item.name)
                        .font(.headline)
                        .lineLimit(2)
                    
                    if let desc = item.descriptionHTML {
                        Text(desc.htmlToAttributedString())
                            .font(.caption)
                            .lineLimit(3)
                    }
                }
            }
        }
    }
}
