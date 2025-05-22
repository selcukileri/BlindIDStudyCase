//
//  MovieService.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

class MovieService {
    static let shared = MovieService()
    private init() {}

    private let baseURL = "https://moviatask.cerasus.app"
    
    func fetchMovies() async throws -> [Movie] {
        guard let url = URL(string: "\(baseURL)/api/movies") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw CustomError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Movie].self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> Movie {
        guard let url = URL(string: "\(baseURL)/api/movies/\(movieId)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw CustomError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Movie.self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
    
    func fetchLikedMovies() async throws -> [Movie] {
        
        guard let token = KeychainHelper.shared.read(key: "userToken"), !token.isEmpty else {
            throw CustomError.unauthorized
        }
        
        guard let url = URL(string: "\(baseURL)/api/users/liked-movies") else {
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
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Movie].self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
    
    func likeMovie(with movieId: Int) async throws -> MessageResponse {
        guard let token = KeychainHelper.shared.read(key: "userToken"), !token.isEmpty else {
            throw CustomError.unauthorized
        }
        
        guard let url = URL(string: "\(baseURL)/api/movies/like/\(movieId)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
            let decoder = JSONDecoder()
            return try decoder.decode(MessageResponse.self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
    
    func unlikeMovie(with movieId: Int) async throws -> MessageResponse {
        guard let token = KeychainHelper.shared.read(key: "userToken"), !token.isEmpty else {
            throw CustomError.unauthorized
        }
        
        guard let url = URL(string: "\(baseURL)/api/movies/unlike/\(movieId)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
            let decoder = JSONDecoder()
            return try decoder.decode(MessageResponse.self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
    
    func fetchLikedMovieIDs() async throws -> [Int] {
        
        guard let token = KeychainHelper.shared.read(key: "userToken"), !token.isEmpty else {
            throw CustomError.unauthorized
        }
        
        guard let url = URL(string: "\(baseURL)/api/users/liked-movie-ids") else {
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
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Int].self, from: data)
        } catch {
            throw CustomError.decodingFailed
        }
    }
}
