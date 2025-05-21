//
//  ProfileViewModel.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 21.05.2025.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchProfile() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await ProfileService.shared.fetchProfile()
            self.user = user
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
