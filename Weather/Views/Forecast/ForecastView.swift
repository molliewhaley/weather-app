//
//  ForecastView.swift
//  Weather
//
//  Created by Mollie Whaley on 6/27/23.
//

import SwiftUI

// forecast for next 4 days
struct ForecastView: View {
    
    @EnvironmentObject private var weatherVM: WeatherViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if let weather = weatherVM.decodedWeatherData {
                ScrollView {
                    VStack(spacing: 20) {
                        Collapsible(
                            label: { // temp, date, and image as label
                                DailyWeatherView(temp: weather.timelines.daily[1].values.intTemperature, date: weather.timelines.daily[1].formattedTime, weatherImage: weatherVM.forecastWeatherImages[0])
                            },
                            content: { // conditions shown when tapped
                                ForecastConditionView(temp1: weather.timelines.daily[1].values.intTemperatureMin, temp2: weather.timelines.daily[1].values.intTemperatureMax, wind: weather.timelines.daily[1].values.intWind, humidity: weather.timelines.daily[1].values.intHumidity)
                            }
                        )
                        
                        Collapsible(
                            label: {
                                DailyWeatherView(temp: weather.timelines.daily[2].values.intTemperature, date: weather.timelines.daily[2].formattedTime, weatherImage: weatherVM.forecastWeatherImages[1])
                            },
                            content: {
                                ForecastConditionView(temp1: weather.timelines.daily[2].values.intTemperatureMin, temp2: weather.timelines.daily[2].values.intTemperatureMax, wind: weather.timelines.daily[2].values.intWind, humidity: weather.timelines.daily[2].values.intHumidity)
                            }
                        )
                        
                        
                        Collapsible(
                            label: {
                                DailyWeatherView(temp: weather.timelines.daily[3].values.intTemperature, date: weather.timelines.daily[3].formattedTime, weatherImage: weatherVM.forecastWeatherImages[2])
                            },
                            content: {
                                ForecastConditionView(temp1: weather.timelines.daily[3].values.intTemperatureMin, temp2: weather.timelines.daily[3].values.intTemperatureMax, wind: weather.timelines.daily[3].values.intWind, humidity: weather.timelines.daily[3].values.intHumidity)
                                
                            }
                        )
                        
                        Collapsible(
                            label: {
                                DailyWeatherView(temp: weather.timelines.daily[4].values.intTemperature, date: weather.timelines.daily[4].formattedTime, weatherImage: weatherVM.forecastWeatherImages[3])
                            },
                            content: {
                                ForecastConditionView(temp1: weather.timelines.daily[4].values.intTemperatureMin, temp2: weather.timelines.daily[4].values.intTemperatureMax, wind: weather.timelines.daily[4].values.intWind, humidity: weather.timelines.daily[4].values.intHumidity)
                                
                            }
                        )
                        
                        Spacer()
                        
                    }
                    .padding(.top, 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
           }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(WeatherViewModel())
    }
}
