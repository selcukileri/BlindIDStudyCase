//
//  AuthService.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    private let baseURL = "https://moviatask.cerasus.app"
    
    func register(name: String, surname: String, email: String, password: String) async throws -> AuthResponse {
        guard let url = URL(string: "\(baseURL)/api/auth/register") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password
        ]
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw CustomError.encodingFailed
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw CustomError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
    
    func login(email: String, password: String) async throws -> AuthResponse {
        guard let url = URL(string: "\(baseURL)/api/auth/login") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw CustomError.encodingFailed
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw CustomError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            throw CustomError.decodingError(error.localizedDescription)
        }
    }
}
