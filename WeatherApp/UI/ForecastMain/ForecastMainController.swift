//
//  ForecastMainController.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import SwiftUI

final class ForecastMainController: UIHostingController<ForecastMainView> {
    init(viewModel: ForecastMainViewModel) {
        super.init(rootView: ForecastMainView(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
