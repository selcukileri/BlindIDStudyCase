//
//  ContentView.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var isRegistered = false
    @State private var goToLogin = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear // gesture'ın çalışması için gerekli

                VStack(spacing: 24) {
                    Group {
                        CustomTextField(title: "Name", text: $name)
                        CustomTextField(title: "Surname", text: $surname)
                        CustomTextField(title: "Email", text: $email, keyboardType: .emailAddress)
                        CustomSecureField(title: "Password", text: $password)
                    }

                    Button(action: {
                        viewModel.register(name: name, surname: surname, email: email, password: password)
                    }) {
                        Text("Register")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clrGreen)
                            .cornerRadius(10)
                    }

                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.secondary)
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(Color.clrGreen)
                        }
                    }
                    .padding(.top, 8)

                    Spacer()
                }
                .padding(.top, 32)
                .padding(.horizontal)
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $isRegistered) {
                TabBarController()
            }
            .onChange(of: viewModel.token) { _, newValue in
                isRegistered = newValue != nil
            }
            .hideKeyboardOnTap()
            .dismissableAlert(message: $viewModel.errorMessage)
        }
    }
}

#Preview {
    RegisterView()
}
