//
//  FavoriteRowView.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 22.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRowView: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {
            WebImage(url: URL(string: movie.posterUrl))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.3))
                .scaledToFill()
                .frame(width: 60, height: 90)
                .clipped()
                .cornerRadius(6)

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)

                Text("\(movie.year) • \(movie.category)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)

                    Text("\(movie.rating)")
                        .font(.subheadline)
                }
            }
        }
        .padding(.vertical, 6)
    }
}
