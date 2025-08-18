//
//  String+EXT.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import SwiftUI

public extension String {
    func htmlToAttributedString(font: UIFont = .systemFont(ofSize: 14)) -> AttributedString {
        guard let data = data(using: .utf8) else { return AttributedString(self) }
        let opts: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let ns = try? NSAttributedString(data: data, options: opts, documentAttributes: nil) {
            return AttributedString(ns)
        }
        return AttributedString(self)
    }
}
