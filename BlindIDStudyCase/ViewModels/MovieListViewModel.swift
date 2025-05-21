//
//  MovieListViewModel.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let movies = try await MovieService.shared.fetchMovies()
            self.movies = movies
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
