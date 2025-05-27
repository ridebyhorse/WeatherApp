//
//  LocationBarView.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 27.05.2025.
//

import SwiftUI

struct LocationBarView: View {
    @Binding var searchText: String
    
    let currentLocation: String
    let onSearchTapAction: () -> Void
    
    @State private var isSearchActive = false
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Image(systemName: "location.fill")
                Text(currentLocation)
                    .font(.headline)
                    .lineLimit(1)
                Button {
                    withAnimation {
                        isSearchActive = true
                    }
                } label: {
                    Image(systemName: "chevron.down")
                }
                if isSearchActive {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search city", text: $searchText)
                            .submitLabel(.search)
                            .onSubmit {
                                isSearchActive = false
                                onSearchTapAction()
                            }
                        Button {
                            isSearchActive = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                } else {
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .padding(12)
            .background(Color.blue.opacity(0.5))
            .cornerRadius(10)
        }
    }
}

#Preview {
    LocationBarView(
        searchText: .constant("Moscow"),
        currentLocation: "Paris",
        onSearchTapAction: { print("Search tapped") }
    )
}
