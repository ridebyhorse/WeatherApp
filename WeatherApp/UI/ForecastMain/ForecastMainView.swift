//
//  ForecastMainView.swift
//  WeatherApp
//
//  Created by Maria Nesterova on 26.05.2025.
//

import SwiftUI

struct WeatherForecastViewItem: Identifiable {
    let id = UUID()
    let day: String
    let temperature: Int
    let condition: String
    let humidity: Int
    let windSpeed: Int
    let weatherImageURL: String
    let hourlyForecast: [HourlyForecastViewItem]?
}

struct HourlyForecastViewItem: Identifiable {
    let id = UUID()
    let time: String
    let temperature: Int
    let weatherImageURL: String
}

struct ForecastMainView: View {
    @ObservedObject var viewModel: ForecastMainViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    LocationBarView(
                        searchText: $viewModel.searchLocationText,
                        currentLocation: viewModel.currentLocation,
                        onSearchTapAction: { viewModel.handleSearchButtonTap() }
                    )
                    VStack(spacing: 20) {
                        if let currentForecast = viewModel.currentForecastViewItem {
                            CurrentDayForecastView(forecastViewItem: currentForecast)
                        }
                        WeeklyForecastView(forecastViewItems: viewModel.weeklyForecastViewItems)
                    }
                    .loadable(isLoading: viewModel.viewState == .loading)
                    .errorState(isError: viewModel.viewState == .error) {
                        ErrorStateView { viewModel.handleRetryButtonTap() }
                    }
                }
                .padding(16)
            }
        }
        .alert(isPresented: $viewModel.isLocationAlertShown) {
            Alert(
                title: Text("Location Not Found"),
                message: Text("The location could not be found. Please try another search."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

private struct CurrentDayForecastView: View {
    let forecastViewItem: WeatherForecastViewItem
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                AsyncImage(url: URL(string: forecastViewItem.weatherImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .tint(.white)
                }
                .frame(width: 128, height: 128)
                Text("\(forecastViewItem.temperature)°")
                    .font(.system(size: 60, weight: .bold))
            }
            Text(forecastViewItem.condition)
                .font(.headline)
                .padding(.bottom, 10)
            HStack(spacing: 20) {
                StatView(systemIconName: "humidity.fill", value: "\(forecastViewItem.humidity)%")
                StatView(systemIconName: "wind", value: "\(forecastViewItem.windSpeed) km/h")
            }
            .padding(.bottom, 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    if let hourlyForecast = forecastViewItem.hourlyForecast {
                        ForEach(hourlyForecast) { hour in
                            HourlyForecastView(hourlyForecastViewItem: hour)
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .padding(12)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(20)
        }
        .foregroundColor(.white)
        .padding(12)
        .background(Color.blue.opacity(0.3))
        .cornerRadius(20)
    }
}

private struct HourlyForecastView: View {
    let hourlyForecastViewItem: HourlyForecastViewItem
    
    var body: some View {
        VStack(spacing: 5) {
            Text(hourlyForecastViewItem.time)
                .font(.caption)
            AsyncImage(url: URL(string: hourlyForecastViewItem.weatherImageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
                    .tint(.white)
            }
            .frame(width: 40, height: 40)
            Text("\(hourlyForecastViewItem.temperature)°")
                .font(.subheadline)
        }
        .foregroundColor(.white)
    }
}

private struct WeeklyForecastView: View {
    let forecastViewItems: [WeatherForecastViewItem]

    var body: some View {
        VStack(alignment: .leading) {
            Text("NEXT FORECAST")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
            ForEach(forecastViewItems) { forecast in
                WeeklyForecastItemView(forecastViewItem: forecast)
                    .padding(7)
            }
            .padding(12)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(20)
        }
        .padding(12)
        .background(Color.blue.opacity(0.3))
        .cornerRadius(20)
    }
}

private struct WeeklyForecastItemView: View {
    let forecastViewItem: WeatherForecastViewItem
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                Text(forecastViewItem.day)
                    .font(.title2)
                AsyncImage(url: URL(string: forecastViewItem.weatherImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .tint(.white)
                }
                .frame(width: 50, height: 50)
                Text(forecastViewItem.condition)
            }
            .foregroundColor(.white)
            Spacer()
            VStack(spacing: 10) {
                Text("\(forecastViewItem.temperature)°C")
                    .font(.title)
                    .foregroundColor(.white)
                HStack(spacing: 20) {
                    StatView(systemIconName: "humidity.fill", value: "\(forecastViewItem.humidity)%")
                    StatView(systemIconName: "wind", value: "\(forecastViewItem.windSpeed) km/h")
                }
            }
        }
    }
}

private struct StatView: View {
    let systemIconName: String
    let value: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
            Text(value)
                .font(.subheadline)
        }
        .foregroundColor(.white)
    }
}

private struct ErrorStateView: View {
    let onRetryButtonTapAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Error loading forecast")
                .font(.headline)
                .padding(12)
            Button {
                onRetryButtonTapAction()
            } label: {
                Text("Retry")
                    .padding(12)
                    .background(.blue.opacity(0.8))
                    .cornerRadius(10)
            }
        }
        .foregroundColor(.white)
    }
}

#Preview {
    ForecastMainView(
        viewModel: ForecastMainViewModel(
            weatherRepository: WeatherRepository(networkService: NetworkService()),
            locationService: LocationService()
        )
    )
}
