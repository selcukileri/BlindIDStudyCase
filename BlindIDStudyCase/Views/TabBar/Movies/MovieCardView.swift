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
                    .frame(width: 120, height: 180)
                    .cornerRadius(8)
                
                WebImage(url: URL(string: movie.posterUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipped()
                    .cornerRadius(8)
            }
            
            HStack(alignment: .top, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            Text("\(movie.year.description) • \(movie.rating)")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}
