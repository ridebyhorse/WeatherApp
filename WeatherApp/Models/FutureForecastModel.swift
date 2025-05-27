//
//  FutureForecastModel.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

struct FutureForecastModel: Decodable {
    let date: Double
    let day: FutureForecastDayModel
    let hour: [FutureForecastHourModel]
    
    enum CodingKeys: String, CodingKey {
        case date = "date_epoch"
        case day, hour
    }
}

struct FutureForecastDayModel: Decodable {
    let averageTemperature: Double
    let maxWindKmPerHour: Double
    let averageHumidity: Double
    let condition: ConditionModel
    
    enum CodingKeys: String, CodingKey {
        case averageTemperature = "avgtemp_c"
        case maxWindKmPerHour = "maxwind_kph"
        case averageHumidity = "avghumidity"
        case condition
    }
}

struct FutureForecastHourModel: Decodable {
    let date: Double
    let temperature: Double
    let condition: ConditionModel
    
    enum CodingKeys: String, CodingKey {
        case date = "time_epoch"
        case temperature = "temp_c"
        case condition
    }
}
