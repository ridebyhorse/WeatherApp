//
//  Environments.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import Foundation

enum Environments {    
    enum ConfigKey: String, CaseIterable {
        case baseUrl = "BASE_URL"
        case weatherApiKey = "WEATHER_API_KEY"
    }

    static var baseUrl: String { value(for: .baseUrl)! }
    static var weatherApiKey: String { value(for: .weatherApiKey)! }
    
    static func setup() {
        #if DEBUG
        checkConfiguration()
        #endif
    }
    
    static func value<T: LosslessStringConvertible>(for key: Environments.ConfigKey) -> T? {
        return try? EnvironmentsConfiguration.value(for: key.rawValue)
    }
    
    private static func checkConfiguration() {
        print("\n---Begin setup environments---")
        print("XCConfig:")
        
        ConfigKey.allCases.forEach { key in
            EnvironmentsConfiguration.checkValue(for: key.rawValue)
        }
        print("---End setup environments---\n")
    }
}
