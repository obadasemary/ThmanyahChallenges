//
//  SearchResultRow.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI

struct SearchResultRow: View {
    
    let result: SearchResultItem
    
    var body: some View {
        switch result {
        case .podcast(let p):
            HStack { Text("🎙️"); Text(p.name) }
        case .episode(let e):
            HStack { Text("🎧"); Text(e.name) }
        case .audioBook(let b):
            HStack { Text("📚"); Text(b.name) }
        case .audioArticle(let a):
            HStack { Text("📰"); Text(a.name) }
        }
    }
}
