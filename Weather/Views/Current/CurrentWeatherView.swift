//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Mollie Whaley on 6/27/23.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @EnvironmentObject private var weatherVM: WeatherViewModel
    @State private var locationEntered = ""
    @State private var cityName = "New York"
    @State private var units = "imperial"
    @State private var changedUnits = "imperial"
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            GeometryReader { _ in
                VStack(alignment: .center, spacing: 40) {
                        VStack {
                            HStack { // search and send info to VM
                                Text("Location: ")
                                TextField("Search New Location", text: $locationEntered)
                                    .frame(height: 10)
                                    .padding()
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                
                                Button {
                                    Task {
                                        if !locationEntered.isEmpty {
                                            cityName = locationEntered
                                            locationEntered = ""
                                            await weatherVM.processWeather(cityName: cityName, units: changedUnits)
                                            units = changedUnits
                                        } else {
                                            weatherVM.errorMessage = "Enter all information"
                                            weatherVM.presentError = true
                                        }
                                        
                                    }
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 30))
                                }
                            }
                            
                            Menu { // units menu
                                Button {
                                    changedUnits = "metric"
                                    
                                } label: {
                                    Text("Metric")
                                }
                                
                                Button {
                                    changedUnits = "imperial"
                                } label: {
                                    Text("Imperial")
                                }
                            } label: {
                                HStack {
                                    Text("Units")
                                    Spacer()
                                    Text(changedUnits)
                                }
                            }
                        }
                        .padding(.horizontal)
                    
                    .alert(isPresented: $weatherVM.presentError) { // handles all alerts from VM
                        Alert(
                            title: Text("Error"),
                            message: Text(weatherVM.errorMessage),
                            dismissButton: .default(Text("OK")) {
                                weatherVM.presentError = false
                            }
                        )}
                    
                    if let weather = weatherVM.decodedWeatherData {
                        VStack(spacing: 20) {
                            Text(cityName.capitalized)
                                .font(.system(size: 30, weight: .heavy, design: .default))
                            
                            Text(weather.timelines.daily[0].formattedTime)
                                .font(.system(size: 20, design: .default))
                                .foregroundColor(Color.black)
                                .frame(width: 240, height: 35)
                                .background(Color.white)
                                .cornerRadius(50)
                            
                            Text(weatherVM.currentWeatherCondition)
                                .lineLimit(2)
                                .font(.system(size: 25))
                        }
                        
                        VStack {
                            if units == "imperial" {
                                Text("\(weather.timelines.daily[0].values.intTemperature)°")
                                    .font(.system(size: 150, weight: .medium))
                            } else {
                                Text("\(weather.timelines.daily[0].values.intTemperature)°C")
                                    .font(.system(size: 150, weight: .medium))
                            }
                        }

                        
                        HStack(spacing: 18) { // displays conditions
                            if units == "imperial" {
                                ConditionView(condition: "\(weather.timelines.daily[0].values.intTemperatureMin)° - \(weather.timelines.daily[0].values.intTemperatureMax)°", conditionImage: "thermometer.medium", conditionTitle: "Min-Max", spacing: 10)
                            } else {
                                ConditionView(condition: "\(weather.timelines.daily[0].values.intTemperatureMin)°C - \(weather.timelines.daily[0].values.intTemperatureMax)°C", conditionImage: "thermometer.medium", conditionTitle: "Min-Max", spacing: 10)
                            }
                            
                            ConditionView(condition: "\(weather.timelines.daily[0].values.intWind)mph", conditionImage: "water.waves", conditionTitle: "Wind", spacing: 13)
                            
                            ConditionView(condition: "\(weather.timelines.daily[0].values.intHumidity)%", conditionImage: "drop.fill", conditionTitle: "Humidity", spacing: 10)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .font(.system(size: 20, weight: .medium))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.white)
                .padding()
                .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
        .onAppear { // uses default parameters to load screen
            Task {
                await weatherVM.processWeather(cityName: cityName, units: units)
            }
        }
    }
}
    
struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView().environmentObject(WeatherViewModel())
    }
}
