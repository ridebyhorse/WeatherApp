//
//  ForecastMainFactory.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

enum ForecastMainFactory {
    static func createForecastMainController() -> ForecastMainController {
        let weatherRepository = WeatherRepository()
        let viewModel = ForecastMainViewModel(weatherRepository: weatherRepository)
        let controller = ForecastMainController(viewModel: viewModel)
        
        return controller
    }
}
