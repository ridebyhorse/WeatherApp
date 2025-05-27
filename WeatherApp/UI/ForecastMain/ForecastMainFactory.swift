//
//  ForecastMainFactory.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

enum ForecastMainFactory {
    static func createForecastMainController() -> ForecastMainController {
        let weatherRepository = WeatherRepository()
        let locationService = LocationService.shared
        let viewModel = ForecastMainViewModel(weatherRepository: weatherRepository, locationService: locationService)
        let controller = ForecastMainController(viewModel: viewModel)
        
        return controller
    }
}
