//
//  ProfileViewModel.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var profile: Profile?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchProfile() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let profile = try await ProfileService.shared.fetchProfile()
            self.profile = profile
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
