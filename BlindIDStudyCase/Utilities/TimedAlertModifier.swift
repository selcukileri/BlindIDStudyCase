//
//  TimedAlertModifier.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 22.05.2025.
//

import SwiftUI

struct TimedAlertModifier: ViewModifier {
    @Binding var message: String?

    func body(content: Content) -> some View {
        content
            .alert(message ?? "", isPresented: Binding(
                get: { message != nil },
                set: { if !$0 { message = nil } }
            )) { }
            .onChange(of: message) { newValue, _ in
                if newValue != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        message = nil
                    }
                }
            }
    }
}

extension View {
    func timedAlert(message: Binding<String?>) -> some View {
        self.modifier(TimedAlertModifier(message: message))
    }
}
