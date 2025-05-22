//
//  Date+Ext.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 22.05.2025.
//

import Foundation

extension String {
    func toFormattedDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: self) else {
            return "-"
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
