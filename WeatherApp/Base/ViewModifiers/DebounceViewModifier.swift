//
//  DebounceViewModifier.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 29.05.2025.
//

import SwiftUI

extension View {
    func onDebouncedTextChange(
        text: Published<String>.Publisher,
        delay: RunLoop.SchedulerTimeType.Stride = 0.5,
        action: @escaping (String) -> Void
    ) -> some View {
        modifier(TextDebounceModifier(text: text, delay: delay, onDebouncedTextChange: action))
    }
}

private struct TextDebounceModifier: ViewModifier {
    let text: Published<String>.Publisher
    let delay: RunLoop.SchedulerTimeType.Stride
    let onDebouncedTextChange: (String) -> Void
    
    @State private var latestText = ""
        
    func body(content: Content) -> some View {
        content
            .onReceive(text.debounce(for: delay, scheduler: RunLoop.main)) { debouncedText in
                if debouncedText != latestText {
                    onDebouncedTextChange(debouncedText)
                    latestText = debouncedText
                }
            }
    }
}
