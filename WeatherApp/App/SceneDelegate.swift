//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let rootViewController = ForecastMainFactory.createForecastMainController()
        
        window?.rootViewController = rootViewController
    }
}
