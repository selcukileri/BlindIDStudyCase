//
//  CustomTextField.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(title, text: $text)
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
            .keyboardType(keyboardType)
    }
}

struct CustomSecureField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        SecureField(title, text: $text)
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
