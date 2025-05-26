//
//  EnvironmentsConfiguration.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import Foundation

enum EnvironmentsConfiguration {
    enum Error: Swift.Error {
        case invalidResource
        case missingKey
        case invalidValue
        case missingValue
    }
    
    static func value<T: LosslessStringConvertible>(for key: String) throws -> T {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }
        guard let string = object as? String, string.isEmpty == false else {
            throw Error.missingValue
        }
        guard let value = T(string) else {
            throw Error.invalidValue
        }
        
        return value
    }
    
    static func checkValue(for key: String) {
        do {
            let stringValue: String = try value(for: key)
            print("Find \(key): \(stringValue)")
        } catch EnvironmentsConfiguration.Error.invalidResource {
            print("Invalid resource for \(key). Check .plist correct name")
        } catch EnvironmentsConfiguration.Error.missingKey {
            print("Missing key \(key). Add key to Info.plist file")
        } catch EnvironmentsConfiguration.Error.missingValue {
            print("Missing value for key \(key)")
        } catch EnvironmentsConfiguration.Error.invalidValue {
            print("Invalid value for key \(key)")
        } catch {
            print("Undefind error for key: \(key)")
        }
    }
}
