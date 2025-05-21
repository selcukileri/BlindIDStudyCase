//
//  Profile.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 22.05.2025.
//

import Foundation

struct Profile: Codable {
    let id: String
    let name: String
    let surname: String
    let email: String
    let likedMovies: [Int]
    let createdAt: String
    let updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, surname, email, likedMovies, createdAt, updatedAt
    }
}
