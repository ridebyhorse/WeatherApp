//
//  LocationService.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 27.05.2025.
//

import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    
    var isAuthorized: Bool { getIsAuthorized() }
    var isAuthorizationNotDetermined: Bool { locationManager.authorizationStatus == .notDetermined }
    
    var geoPosition: (Double, Double)? { getGeoPosition() }
    var onLocationUpdateAction: ((Double, Double) -> Void)?
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        onLocationUpdateAction?(location.coordinate.latitude, location.coordinate.longitude)
        onLocationUpdateAction = nil
        
        locationManager.stopUpdatingLocation()
    }
    
    private func getIsAuthorized() -> Bool {
        let status = locationManager.authorizationStatus
        
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
    private func getGeoPosition() -> (Double, Double)? {
        guard let location = locationManager.location?.coordinate else {
            return nil
        }
        
        return (location.latitude, location.longitude)
    }
}

