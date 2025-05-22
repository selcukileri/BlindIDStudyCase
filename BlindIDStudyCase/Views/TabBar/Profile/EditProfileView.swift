//
//  EditProfileView.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 22.05.2025.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Name", text: $name)
                    TextField("Surname", text: $surname)
                }
                
                Section(header: Text("Login")) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await viewModel.updateProfile(
                                name: name.isEmpty ? nil : name,
                                surname: surname.isEmpty ? nil : surname,
                                email: email.isEmpty ? nil : email,
                                password: password.isEmpty ? nil : password
                            )
                            await viewModel.fetchProfile()
                            dismiss()
                        }
                    }
                }
            }
            .timedAlert(message: $viewModel.alertMessage)
            .onAppear {
                name = viewModel.profile?.name ?? ""
                surname = viewModel.profile?.surname ?? ""
                email = viewModel.profile?.email ?? ""
            }
        }
    }
}
#Preview {
    EditProfileView(viewModel: ProfileViewModel())
}
