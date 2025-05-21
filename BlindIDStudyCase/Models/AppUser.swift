//
//  AppUser.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import Foundation

struct AuthResponse: Codable {
    let token: String
}

struct AppUser: Codable {
    let id: Int
    let name: String
    let surname: String
    let email: String
}
