//
//  AuthViewModel.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var token: String?
    @Published var errorMessage: String?
    
    func login(email: String, password: String) {
        Task {
            do {
                let response = try await AuthService.shared.login(email: email, password: password)
                self.token = response.token
                saveToken(response.token)
            } catch let error as CustomError {
                self.errorMessage = error.localizedDescription
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func register(name: String, surname: String, email: String, password: String) {
        Task {
            do {
                let response = try await AuthService.shared.register(name: name, surname: surname, email: email, password: password)
                self.token = response.token
                saveToken(response.token)
            } catch let error as CustomError {
                self.errorMessage = error.localizedDescription
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func saveToken(_ token: String) {
        let saved = KeychainHelper.shared.save(key: "userToken", value: token)
        print("token: \(token)")
        if !saved {
            print("token couldnt be saved")
        } else {
            print("token saved")
        }
    }
}
