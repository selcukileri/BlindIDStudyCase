//
//  FavoritesView.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading favorites...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.favoriteMovies.isEmpty {
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.favoriteMovies, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(movieID: movie.id)
                        } label: {
                            FavoriteRowView(movie: movie)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
            .task {
                await viewModel.fetchFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView()
}
