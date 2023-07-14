//
//  ForecastConditionView.swift
//  Weather
//
//  Created by Mollie Whaley on 7/3/23.
//

import SwiftUI

// view when collapsible button is tapped
struct ForecastConditionView: View {
    
    @EnvironmentObject private var weatherVM: WeatherViewModel
    let temp1: Int
    let temp2: Int
    let wind: Int
    let humidity: Int
    
    var body: some View {
        HStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Min - Max")
                Text("Wind")
                Text("Humidity")
            }
            
            VStack(spacing: 8) {
                Image(systemName: "thermometer.medium")
                Image(systemName: "water.waves")
                Image(systemName: "drop.fill")
            }
            
            VStack(alignment: .leading, spacing: 8) {
                if weatherVM.units == "imperial" {
                    Text("\(temp1)° - \(temp2)°")
                } else {
                    Text("\(temp1)°C - \(temp2)°C")
                }
                Text("\(wind)mph")
                Text("\(humidity)%")
                
            }
        }
        .padding(.vertical)
    }
}

struct ForecastConditionView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastConditionView(temp1: 24, temp2: 42, wind: 24, humidity: 42)
            .environmentObject(WeatherViewModel())
    }
}
