//
//  FavoritesViewModel.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchFavorites() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let favoriteMovies = try await MovieService.shared.fetchLikedMovies()
            self.favoriteMovies = favoriteMovies
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
