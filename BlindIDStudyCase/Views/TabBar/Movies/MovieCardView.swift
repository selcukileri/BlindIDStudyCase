//
//  MovieCardView.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            WebImage(url: URL(string: movie.posterUrl))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 140, height: 180)
                .clipped()
                .cornerRadius(8)
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text("\(movie.year.description) • \(movie.rating)")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}
