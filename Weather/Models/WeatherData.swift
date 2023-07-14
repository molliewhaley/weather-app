//
//  WeatherData.swift
//  Weather
//
//  Created by Mollie Whaley on 6/27/23.
//

import Foundation

struct WeatherData: Codable {
    let timelines: Timelines
}

struct Timelines: Codable {
    let daily: [Daily]
}

struct Daily: Codable {
    let values: Values
    let time: String
    
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = dateFormatter.date(from: time) {
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "EEEE, MMMM d"
            return newDateFormatter.string(from: date)
        }
        return ""
    }
}

struct Values: Codable {
    let temperatureMin: Double
    let temperatureMax: Double
    let humidityAvg: Double
    let windSpeedAvg: Double
    let weatherCodeMin: Int
    let temperatureAvg: Double
    
    var intTemperatureMin: Int {
        return Int(temperatureMin)
    }
    var intTemperatureMax: Int {
        return Int(temperatureMax)
    }
    var intTemperature: Int {
        return Int(temperatureAvg)
    }
    var intHumidity: Int {
        return Int(humidityAvg)
    }
    var intWind: Int {
        return Int(windSpeedAvg)
    }
}
