//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Mollie Whaley on 6/27/23.
//


import Foundation

// VM for current and forecast views

@MainActor
class WeatherViewModel: ObservableObject {
    
    private let apiClient = WeatherClient()
    private let weatherCode = WeatherCode()
    @Published var decodedWeatherData: WeatherData?
    @Published var units = ""
    @Published var presentError = false
    @Published var errorMessage = ""
    @Published var currentWeatherCondition = ""
    @Published var forecastWeatherImages: [String] = []
    
    // send info over to WeatherClient and catch errors
    func processWeather(cityName: String, units: String) async {
        do {
            let results = try await apiClient.getWeather(cityName: cityName, units: units)
            self.decodedWeatherData = results
            self.units = units
            self.currentWeatherCondition = self.weatherCode.getWeatherCondition(weatherCode:self.decodedWeatherData?.timelines.daily[0].values.weatherCodeMin ?? 0)
                self.getForecastImages()
            
        } catch ApiError.invalidURL {
                self.presentError = true
                self.errorMessage = "Invalid url"
        } catch ApiError.invalidResponse {
                self.presentError = true
                self.errorMessage = "Server error"
        } catch ApiError.invalidData {
                self.presentError = true
                self.errorMessage = "Invalid data"
        } catch {
                self.presentError = true
                self.errorMessage = "Unexpected problem. Try again."
        }
        
    }
    
    // array with forecast images
    private func getForecastImages() {
        forecastWeatherImages = []
        for i in 0..<4 {
            guard let dailyCode = decodedWeatherData?.timelines.daily[i].values.weatherCodeMin else {
                print("Couldn't get daily images")
                return
            }
            let image = weatherCode.getWeatherImage(weatherCode: dailyCode)
            forecastWeatherImages.append(image)
        }
    }

}
        


