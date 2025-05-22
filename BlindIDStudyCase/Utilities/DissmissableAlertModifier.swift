//
//  DissmissableAlertModifier.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 22.05.2025.
//

import SwiftUI

struct DismissableAlertModifier: ViewModifier {
    @Binding var message: String?

    func body(content: Content) -> some View {
        content
            .alert(message ?? "", isPresented: Binding(
                get: { message != nil },
                set: { newValue in
                    if !newValue {
                        message = nil
                    }
                }
            )) {
                Button("OK", role: .cancel) {
                    message = nil
                }
            }
    }
}

extension View {
    func dismissableAlert(message: Binding<String?>) -> some View {
        self.modifier(DismissableAlertModifier(message: message))
    }
}
