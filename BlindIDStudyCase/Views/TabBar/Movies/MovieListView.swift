//
//  MovieListView.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MoviesViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 24) {
                            ForEach(viewModel.sortedCategories, id: \.self) { category in
                                if let movies = viewModel.categorizedMovies[category] {
                                    CategorySectionView(
                                        category: category,
                                        movies: movies,
                                        likedMovieIDs: viewModel.likedMovieIDs
                                    )
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.leading, 8)
                    }
                    .refreshable {
                        try? await Task.sleep(nanoseconds: 600_000_000)
                        await viewModel.fetchMovies()
                        await viewModel.fetchLikedMovieIDs()
                    }
                }
            }
            .navigationTitle("Movies")
            .task {
                async let moviesTask: () = viewModel.fetchMovies()
                async let likedTask: () = viewModel.fetchLikedMovieIDs()
                _ = await (moviesTask, likedTask)
            }
        }
    }
}

#Preview {
    MovieListView()
}
