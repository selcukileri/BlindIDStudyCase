//
//  CategorySectionView.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import SwiftUI

struct CategorySectionView: View {
    let category: String
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(category)
                .font(.title2.bold())
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                       LazyHStack(spacing: 16) {
                           ForEach(movies) { movie in
                               NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                   MovieCardView(movie: movie)
                               }
                               .padding(.horizontal, 8)
                               .buttonStyle(.plain)
                           }
                       }
                .padding(.horizontal, 8)
            }
        }
    }
}
