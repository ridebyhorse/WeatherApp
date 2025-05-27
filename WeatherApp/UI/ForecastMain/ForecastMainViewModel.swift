//
//  ForecastMainViewModel.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import Foundation

final class ForecastMainViewModel: ObservableObject {
    enum ViewState {
        case loading
        case content
        case error
    }
    
    @Published var viewState: ViewState = .loading
    @Published var searchLocationText = ""
    @Published var currentForecastViewItem: WeatherForecastViewItem?
    @Published var weeklyForecastViewItems: [WeatherForecastViewItem] = []
    @Published var isLocationAlertShown = false
    
    var currentLocation = ""
    
    private let weatherRepository: WeatherRepository
    private let locationService: LocationService
    
    init(weatherRepository: WeatherRepository, locationService: LocationService) {
        self.weatherRepository = weatherRepository
        self.locationService = locationService
        
        if locationService.isAuthorizationNotDetermined {
            locationService.requestLocation()
        }
        
        locationService.onLocationUpdateAction = { [weak self] lat, lon in
            self?.searchLocation(search: "\(lat), \(lon)")
        }
        
        if locationService.isAuthorized, let geoPosition = locationService.geoPosition {
            searchLocation(search: "\(geoPosition.0), \(geoPosition.1)")
        } else {
            currentLocation = "Moscow"
            getForecast(city: currentLocation)
        }
    }
    
    func handleRetryButtonTap() {
        getForecast(city: currentLocation)
    }
    
    func handleSearchButtonTap() {
        searchLocation(search: searchLocationText)
    }
    
    private func getForecast(city: String, days: Int = 7) {
        viewState = .loading
        
        Task { @MainActor in
            do {
                let forecast = try await weatherRepository.getForecast(city: city, days: days)
                mapToWeatherForecastViewItem(forecast)
                viewState = .content
            } catch {
                viewState = .error
            }
        }
    }
    
    private func searchLocation(search: String) {
        searchLocationText = ""
        
        Task { @MainActor in
            do {
                let location = try await weatherRepository.searchCity(city: search)
                if let searchedLocation = location.first?.name {
                    currentLocation = searchedLocation
                    getForecast(city: currentLocation)
                } else {
                    isLocationAlertShown = true
                }
            } catch {
                isLocationAlertShown = true
            }
        }
    }
    
    private func mapToWeatherForecastViewItem(_ model: ForecastModel) {
        let formattedUrl = "https:\(model.current.condition.icon.replacingOccurrences(of: "64", with: "128"))"
        
        currentForecastViewItem = WeatherForecastViewItem(
            day: Date().formatted(Date.FormatStyle().weekday(.wide)),
            temperature: Int(model.current.temperature),
            condition: model.current.condition.text,
            humidity: Int(model.current.humidity),
            windSpeed: Int(model.current.windKmPerHour),
            weatherImageURL: formattedUrl,
            hourlyForecast: model.forecast.forecastDay.first?.hour.map { hour in
                HourlyForecastViewItem(
                    time: Date(timeIntervalSince1970: TimeInterval(hour.date))
                        .formatted(Date.FormatStyle().hour(.conversationalDefaultDigits(amPM: .wide))),
                    temperature: Int(hour.temperature),
                    weatherImageURL: "https:\(hour.condition.icon)"
                )
            }
        )
        
        weeklyForecastViewItems = model.forecast.forecastDay.map { day in
            WeatherForecastViewItem(
                day: Date(timeIntervalSince1970: TimeInterval(day.date)).formatted(Date.FormatStyle().weekday(.wide)),
                temperature: Int(day.day.averageTemperature),
                condition: day.day.condition.text,
                humidity: Int(day.day.averageHumidity),
                windSpeed: Int(day.day.maxWindKmPerHour),
                weatherImageURL: "https:\(day.day.condition.icon)",
                hourlyForecast: nil
            )
        }
    }
}
