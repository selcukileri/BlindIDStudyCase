//
//  Extension.swift
//  BlindIDStudyCase
//
//  Created by Selçuk İleri on 22.05.2025.
//

import SwiftUI

struct HideKeyboardOnTapModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        modifier(HideKeyboardOnTapModifier())
    }
}
