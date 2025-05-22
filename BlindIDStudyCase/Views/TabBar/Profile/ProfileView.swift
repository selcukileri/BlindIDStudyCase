//
//  ProfileView.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showEditSheet = false
    
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
                    VStack(spacing: 24) {
                        
                        VStack(spacing: 8) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                            
                            Text("\(profile.name) \(profile.surname)")
                                .font(.title2.bold())
                            
                            Text(profile.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                Text("Liked Movies: \(profile.likedMovies.count)")
                            }
                            
                            HStack {
                                Image(systemName: "calendar.badge.plus")
                                    .foregroundColor(.blue)
                                Text("Joined on: \(profile.createdAt.toFormattedDate())")
                            }
                            
                            HStack {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .foregroundColor(.orange)
                                Text("Last update: \(profile.updatedAt.toFormattedDate())")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                        Button(action: {
                            showEditSheet = true
                        }) {
                            Text("Update Profile")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding()
                } else {
                    Text("No user data.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Profile")
            .task {
                await viewModel.fetchProfile()
            }
            .sheet(isPresented: $showEditSheet) {
                EditProfileView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ProfileView()
}
