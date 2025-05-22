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
    @Published var likedMovieIDs: [Int] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var alertMessage: String?
    
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
    
    func fetchLikedMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let movies = try await MovieService.shared.fetchMovies()
            self.movies = movies
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func likeMovie(with movieId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await MovieService.shared.likeMovie(with: movieId)
            self.alertMessage = response.message
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func unlikeMovie(with movieId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await MovieService.shared.unlikeMovie(with: movieId)
            self.alertMessage = response.message
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchLikedMovieIDs() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let ids = try await MovieService.shared.fetchLikedMovieIDs()
            self.likedMovieIDs = ids
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
