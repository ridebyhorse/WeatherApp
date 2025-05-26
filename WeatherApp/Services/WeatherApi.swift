//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import Foundation
import Moya

enum WeatherApi {
    case getForecast(city: String, days: Int)
    case searchCity(city: String)
}

extension WeatherApi: TargetType {
    var baseURL: URL { getBaseURL() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Moya.Task { getTask() }
    var headers: [String: String]? { getHeaders() }
    var parameters: [String: Any] { getParameters() }

    private func getBaseURL() -> URL { URL(string: Environments.baseUrl)! }

    private func getPath() -> String {
        switch self {
        case .getForecast:
            return "/forecast.json"
        case .searchCity:
            return "/search.json"
        }
    }

    private func getMethod() -> Moya.Method {
        switch self {
        case .getForecast, .searchCity:
            return .get
        }
    }

    private func getTask() -> Moya.Task {
        switch self {
        case .getForecast, .searchCity:
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
            )
        }
    }
    
    private func getParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .searchCity(let city):
            parameters["q"] = city
            parameters["key"] = Environments.weatherApiKey
        case let .getForecast(city, days):
            parameters["q"] = city
            parameters["days"] = days
            parameters["key"] = Environments.weatherApiKey
        }
        
        return parameters
    }
    
    private func getHeaders() -> [String: String]? {
        switch self {
        case .getForecast, .searchCity:
            return [:]
        }
    }
}
