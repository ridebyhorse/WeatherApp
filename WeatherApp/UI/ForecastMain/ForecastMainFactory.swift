//
//  ForecastMainFactory.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

enum ForecastMainFactory {
    @MainActor static func createForecastMainController(networkService: NetworkService) -> ForecastMainController {
        let weatherRepository = WeatherRepository(networkService: networkService)
        let locationService = LocationService()
        let viewModel = ForecastMainViewModel(weatherRepository: weatherRepository, locationService: locationService)
        let controller = ForecastMainController(viewModel: viewModel)
        
        return controller
    }
}
