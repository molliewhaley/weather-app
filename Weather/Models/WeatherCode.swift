//
//  WeatherCode.swift
//  Weather
//
//  Created by Mollie Whaley on 6/28/23.
//

import Foundation

struct WeatherCode {
    
    // description based on condition 
    func getWeatherCondition(weatherCode: Int) -> String {
        switch weatherCode {
        case 1000, 1100:
            return "clear skies."
        case 1001, 1101, 1102:
            return "cloudy."
        case 2000:
            return "fog."
        case 4000, 4200:
            return "drizzle."
        case 4001, 4201:
            return "rain."
        case 5000, 5001, 5100, 5101:
            return "snow."
        case 6000, 6001, 6200, 6201:
            return "freezing rain."
        case 7000, 7101, 7102:
            return "ice pellets."
        case 8000:
            return "thunderstorms."
        
        default:
            return "unknown weather."
        }
    }
    
    // images based on condition
    func getWeatherImage(weatherCode: Int) -> String {
        switch weatherCode {
        case 1000, 1100:
            return "sun.max.fill"
        case 1001, 1101, 1102:
            return "cloud.fill"
        case 2000:
            return "cloud.fog.fill"
        case 4000, 4200:
            return "cloud.drizzle.fill"
        case 4001, 4201:
            return "cloud.rain.fill"
        case 5000, 5001, 5100, 5101:
            return "snowflake"
        case 6000, 6001, 6200, 6201, 7000, 7101, 7102:
            return "cloud.snow.fill"
        case 8000:
            return "cloud.bolt.rain.fill"
        
        default:
            return "cloud.fill"
        }
    }
}
