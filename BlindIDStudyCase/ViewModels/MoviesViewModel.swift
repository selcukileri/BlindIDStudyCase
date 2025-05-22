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
        await perform({ try await MovieService.shared.fetchMovies() }, assignTo: \.movies)
    }
    
    var categorizedMovies: [String: [Movie]] {
        Dictionary(grouping: movies, by: { $0.category })
    }
    
    var sortedCategories: [String] {
        categorizedMovies.keys.sorted()
    }
    
    func fetchMovieDetails(with movieID: Int) async {
        await perform({ try await MovieService.shared.fetchMovieDetails(movieId: movieID) }, assignTo: \.movieDetails)
    }
    
    func fetchLikedMovies() async {
        await perform({ try await MovieService.shared.fetchMovies() }, assignTo: \.movies)
    }
    
    func likeMovie(with movieId: Int) async {
        await perform({ try await MovieService.shared.likeMovie(with: movieId) }, showAlert: true)
    }
    
    func unlikeMovie(with movieId: Int) async {
        await perform({ try await MovieService.shared.unlikeMovie(with: movieId) }, showAlert: true)
    }
    
    func fetchLikedMovieIDs() async {
        await perform({ try await MovieService.shared.fetchLikedMovieIDs() }, assignTo: \.likedMovieIDs)
    }

    private func perform<T>(
        _ task: @escaping () async throws -> T,
        assignTo keyPath: ReferenceWritableKeyPath<MoviesViewModel, T>? = nil,
        showAlert: Bool = false
    ) async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await task()
            if let keyPath = keyPath {
                self[keyPath: keyPath] = result
            }
            if showAlert, let messageResponse = result as? MessageResponse {
                self.alertMessage = messageResponse.message
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
