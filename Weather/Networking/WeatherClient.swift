//
//  CurrentWeatherClient.swift
//  Weather
//
//  Created by Mollie Whaley on 6/27/23.
//

import Foundation

class WeatherClient {
    
    private var cityNameConverted = ""
    
    func getWeather(cityName: String, units: String) async throws -> WeatherData {
        if cityName.contains(" ") { // handles city names with spaces 
            cityNameConverted = cityName.replacingOccurrences(of: " ", with: "%20")
        } else {
            cityNameConverted = cityName
        }
        
        guard let url = URL(string: "https://api.tomorrow.io/v4/weather/forecast?location=\(cityNameConverted)&timesteps=1d&units=\(units)&apikey=\(apiKey)") else {
               print("Invalid URL")
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherData.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
        
    }
}
