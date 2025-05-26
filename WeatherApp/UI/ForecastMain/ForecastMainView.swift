//
//  ForecastMainView.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import SwiftUI

struct ForecastMainView: View {
    @ObservedObject var viewModel: ForecastMainViewModel

    var body: some View {
        Text("ForecastMain module created!")
    }
}

#Preview {
    ForecastMainView(viewModel: ForecastMainViewModel(weatherRepository: WeatherRepository()))
}
