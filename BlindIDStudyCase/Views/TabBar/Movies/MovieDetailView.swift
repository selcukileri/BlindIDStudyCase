//
//  MovieDetailView.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    let movieID: Int
    @StateObject private var viewModel = MoviesViewModel()
    @State private var isFavorite: Bool = false
    @State private var showAlert = false
    @State private var alertText: String?

    var body: some View {
        Group {
            if let movie = viewModel.movieDetails {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        WebImage(url: URL(string: movie.posterUrl))
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade(duration: 0.3))
                            .aspectRatio(2/3,contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.3))
                            .clipped()
                            .cornerRadius(12)
                        
                        Text(movie.title)
                            .font(.title.bold())

                        Text("\(movie.year.description) - \(movie.category)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text("\(movie.rating)")
                            
                        }
                        
                        .font(.subheadline)
                        Text(movie.description)
                            .font(.body)
                            .padding(.top)
                        
                        if !movie.actors.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Actors")
                                    .font(.headline)

                                ForEach(movie.actors, id: \.self) { actor in
                                    Text(actor)
                                        .font(.subheadline)
                                }
                            }
                            .padding(.top)
                        }
                    }
                    .padding()
                }
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isFavorite.toggle()
                    Task {
                        if isFavorite {
                            await viewModel.likeMovie(with: movieID)
                        } else {
                            await viewModel.unlikeMovie(with: movieID)
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            viewModel.alertMessage = nil
                        }
                    }
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
        }
        .task {
            await viewModel.fetchMovieDetails(with: movieID)
            if let movie = viewModel.movieDetails,
               let profile = try? await ProfileService.shared.fetchProfile() {
                isFavorite = profile.likedMovies.contains(movie.id)
            }
        }
//        timedAlert(message: $viewModel.alertMessage)
    }
}

#Preview {
    MovieDetailView(movieID: 1)
}
