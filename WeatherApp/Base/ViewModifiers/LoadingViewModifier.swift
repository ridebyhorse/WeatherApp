//
//  LoadingViewModifier.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 27.05.2025.
//

import SwiftUI

extension View {
    func loadable(isLoading: Bool) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}

private struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        if isLoading {
            ProgressView()
                .tint(.white)
                .padding(20)
        } else {
            content
        }
    }
}
