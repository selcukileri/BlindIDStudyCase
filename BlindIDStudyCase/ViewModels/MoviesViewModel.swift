//
//  MovieListViewModel.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var movieDetails: Movie?
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
    
    var categorizedMovies: [String: [Movie]] {
        Dictionary(grouping: movies, by: { $0.category })
    }
    
    var sortedCategories: [String] {
        categorizedMovies.keys.sorted()
    }
    
    func fetchMovieDetails(with movieID: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let movieDetails = try await MovieService.shared.fetchMovieDetails(movieId: movieID)
            self.movieDetails = movieDetails
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
