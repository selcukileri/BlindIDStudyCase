//
//  MainView.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import SwiftUI

struct TabBarController: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    TabBarController()
}
