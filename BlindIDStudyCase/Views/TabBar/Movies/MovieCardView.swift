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
    let isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 140, height: 210)
                    .cornerRadius(8)
                
                WebImage(url: URL(string: movie.posterUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 210)
                    .clipped()
                    .cornerRadius(8)
            }
            
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            HStack(spacing: 8) {
                Text("\(movie.year.description) • \(movie.rating)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
        }
        .frame(width: 140)
    }
}
