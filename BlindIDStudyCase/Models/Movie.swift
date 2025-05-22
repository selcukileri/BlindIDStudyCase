//
//  Movie.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let year: Int
    let rating: Decimal
    let actors: [String]
    let category: String
    let posterUrl: String
    let description: String
}

struct MessageResponse: Codable {
    let message: String
}
