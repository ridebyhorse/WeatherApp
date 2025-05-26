//
//  CurrentForecastModel.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

struct CurrentForecastModel: Decodable {
    let temperature: Double
    let condition: ConditionModel
    let windKmPerHour: Double
    let windDirection: String
    let humidity: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case condition, humidity
        case temperature = "temp_c"
        case windKmPerHour = "wind_kph"
        case windDirection = "wind_dir"
        case feelsLike = "feelslike_c"
    }
}

struct ConditionModel: Decodable {
    let text: String
    let icon: String
}
