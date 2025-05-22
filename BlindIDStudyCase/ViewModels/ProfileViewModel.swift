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
    @Published var alertMessage: String?
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
    
    func updateProfile(name: String?, surname: String?, email: String?, password: String?) async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await ProfileService.shared.updateProfile(
                name: name,
                surname: surname,
                email: email,
                password: password
            )
            self.alertMessage = response.message
        } catch {
            print("updateError: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
