//
//  ProfileView.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading profile...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let profile = viewModel.profile {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("\(profile.name) \(profile.surname)")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Email: \(profile.email)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("No user data.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Profile")
            .task {
                await viewModel.fetchProfile()
            }
        }
    }
}

#Preview {
    ProfileView()
}
