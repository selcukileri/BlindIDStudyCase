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
    
    private func sendRequest<T: Decodable>(_ endpoint: String, method: String = "GET", tokenRequired: Bool = false) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if tokenRequired {
            guard let token = KeychainHelper.shared.read(key: "userToken"), !token.isEmpty else {
                throw CustomError.unauthorized
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw CustomError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw CustomError.httpError(statusCode: httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
    
    func fetchMovies() async throws -> [Movie] {
        try await sendRequest("/api/movies")
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> Movie {
        try await sendRequest("/api/movies/\(movieId)")
    }
    
    func fetchLikedMovies() async throws -> [Movie] {
        try await sendRequest("/api/users/liked-movies", tokenRequired: true)
    }
    
    func likeMovie(with movieId: Int) async throws -> MessageResponse {
        try await sendRequest("/api/movies/like/\(movieId)", method: "POST", tokenRequired: true)
    }
    
    func unlikeMovie(with movieId: Int) async throws -> MessageResponse {
        try await sendRequest("/api/movies/unlike/\(movieId)", method: "POST", tokenRequired: true)
    }
    
    func fetchLikedMovieIDs() async throws -> [Int] {
        try await sendRequest("/api/users/liked-movie-ids", tokenRequired: true)
    }
}
