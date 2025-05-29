//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import Foundation

final class WeatherRepository: Sendable {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getForecast(city: String, days: Int) async throws -> ForecastModel {
        return try await networkService.request(WeatherApi.getForecast(city: city, days: days))
    }
    
    func searchCity(city: String) async throws -> [LocationModel] {
        return try await networkService.request(WeatherApi.searchCity(city: city))
    }
}
