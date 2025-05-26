//
//  ForecastMainViewModel.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import Foundation

final class ForecastMainViewModel: ObservableObject {
    private let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
}
