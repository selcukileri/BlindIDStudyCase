//
//  AppUser.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import Foundation

struct AuthResponse: Codable {
    let token: String
    let user: User
}

struct User: Codable {
    let id: String
    let name: String
    let surname: String
    let email: String
}
