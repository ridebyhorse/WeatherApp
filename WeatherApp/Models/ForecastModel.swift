//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

struct ForecastModel: Decodable {
    let location: LocationModel
    let current: CurrentForecastModel
    let forecast: ForecastDayModel
}

struct ForecastDayModel: Decodable {
    let forecastDay: [FutureForecastModel]
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}
