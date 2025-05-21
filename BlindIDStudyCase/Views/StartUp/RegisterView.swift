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
    
    var body: some View {
        NavigationStack {
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


                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal)
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $isRegistered) {
                LoginView()
            }
            .onChange(of: viewModel.token) { _, newValue in
                isRegistered = newValue != nil
            }
        }
    }
}

#Preview {
    RegisterView()
}
