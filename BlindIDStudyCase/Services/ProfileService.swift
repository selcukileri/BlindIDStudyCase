//
//  ProfileService.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

class ProfileService {
    static let shared = ProfileService()
    private init() {}

    private let baseURL = "https://moviatask.cerasus.app"
    
    func fetchProfile() async throws -> Profile {
        
        guard let token = KeychainHelper.shared.read(key: "userToken"), !token.isEmpty else {
            throw CustomError.unauthorized
        }
        
        guard let url = URL(string: "\(baseURL)/api/auth/me") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw CustomError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(Profile.self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
}
