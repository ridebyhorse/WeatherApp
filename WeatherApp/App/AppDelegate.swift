//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        Environments.setup()
        
        return true
    }
}
