//
//  AuthService.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import Foundation

final class AuthService {
    static let shared = AuthService()
    private init() {}

    private let baseURL = "https://moviatask.cerasus.app"

    func register(name: String, surname: String, email: String, password: String) async throws -> AuthResponse {
        let body = [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password
        ]
        let url = try makeURL(endpoint: "/api/auth/register")
        let request = try makeRequest(url: url, method: .POST)
        return try await send(request, body: body)
    }

    func login(email: String, password: String) async throws -> AuthResponse {
        let body = [
            "email": email,
            "password": password
        ]
        let url = try makeURL(endpoint: "/api/auth/login")
        let request = try makeRequest(url: url, method: .POST)
        return try await send(request, body: body)
    }

    // MARK: - Helpers

    private func makeURL(endpoint: String) throws -> URL {
        guard let url = URL(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        return url
    }

    private func makeRequest(url: URL, method: HTTPMethod, token: String? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }

    private func send<T: Decodable>(_ request: URLRequest, body: Encodable?) async throws -> T {
        var mutableRequest = request

        if let body = body {
            do {
                mutableRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw CustomError.encodingFailed
            }
        }

        let (data, response) = try await URLSession.shared.data(for: mutableRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            if let responseString = String(data: data, encoding: .utf8) {
                print("Server error response: \(responseString)")
                if let message = try? JSONDecoder().decode(ServerError.self, from: data) {
                    throw CustomError.decodingError(message.error ?? message.message ?? "Unknown error")
                }
            }
            throw CustomError.httpError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}
