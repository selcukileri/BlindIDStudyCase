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
        request.httpMethod = "POST"
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
    
}
