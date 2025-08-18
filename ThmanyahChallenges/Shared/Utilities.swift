//
//  Utilities.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import Foundation
import UIKit

protocol UtilitiesProtocol: AnyObject {
    static func convertStringToDate(_ dateString: String, withFormat format: String) -> Date?
    static func convertDateToString(_ date: Date?, withFormat format: String, locale: Locale) -> String?
    static func formatDuration(_ seconds: Int) -> String
}

final class Utilities: UtilitiesProtocol {
    private static let dateFormatter = DateFormatter()
    static let defaultDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

    class func convertStringToDate(_ dateString: String, withFormat format: String) -> Date? {
        dateFormatter.dateFormat = format.isEmpty ? defaultDateFormat : format
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return nil
    }

    class func convertDateToString(_ date: Date?, withFormat format: String, locale: Locale) -> String? {
        guard let date = date else { return nil }
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        return dateFormatter.string(from: date)
    }
    
    // Arabic-friendly duration formatting: "س" hours, "د" minutes
    class func formatDuration(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours)س \(minutes)د"
        } else if hours > 0 {
            return "\(hours)س"
        } else if minutes > 0 {
            return "\(minutes)د"
        } else {
            return "أقل من دقيقة"
        }
    }
}

extension Date {
    func timeAgoDisplay(locale: Locale? = nil) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        if let locale = locale { formatter.locale = locale }
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}


