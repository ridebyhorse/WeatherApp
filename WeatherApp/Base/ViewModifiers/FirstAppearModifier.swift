//
//  FirstAppearModifier.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 27.05.2025.
//

import SwiftUI

extension View {
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(FirstAppearModifier(action: action))
    }
}

private struct FirstAppearModifier: ViewModifier {
    let action: () -> Void
    
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard hasAppeared == false else {
                return
            }
            
            hasAppeared = true
            action()
        }
    }
}
