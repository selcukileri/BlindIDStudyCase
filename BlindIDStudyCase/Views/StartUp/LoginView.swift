//
//  LoginView.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = AuthViewModel()

    @State private var email = "john@john.com"
    @State private var password = "password123"
    @State private var isRegistered = false
    @State private var showAlert: Bool = false

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Group {
                    CustomTextField(title: "Email", text: $email, keyboardType: .emailAddress)
                    CustomSecureField(title: "Password", text: $password)
                }

                Button(action: {
                    viewModel.login(email: email, password: password)
                }) {
                    Text("Login")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.clrGreen)
                        .cornerRadius(10)
                }
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)

                    NavigationLink("Register") {
                        RegisterView()
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color.clrGreen)
                }
                .padding(.top, 8)
                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal)
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $isRegistered) {
                TabBarController()
            }
            .onChange(of: viewModel.token) { _, newValue in
                isRegistered = newValue != nil
            }
        }
        .hideKeyboardOnTap()
        .dismissableAlert(message: $viewModel.errorMessage)
    }
}

#Preview {
    LoginView()
}
