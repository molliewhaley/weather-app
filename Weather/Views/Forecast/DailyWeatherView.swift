//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Mollie Whaley on 7/2/23.
//

import SwiftUI

// label for collapsible button
struct DailyWeatherView: View {
    
    @EnvironmentObject private var weatherVM: WeatherViewModel
    let temp: Int
    let date: String
    let weatherImage: String
    
    var body: some View {
            HStack {
                if weatherVM.units == "imperial" {
                    Text("\(temp)°")
                        .font(.system(size: 30, weight: .medium))
                        .frame(maxWidth: 85)
                } else {
                    Text("\(temp)°C")
                        .font(.system(size: 30, weight: .medium))
                        .frame(maxWidth: 85)
                }
                
                Text(date)
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: 200)
                    .multilineTextAlignment(.center)
                
                Image(systemName: weatherImage)
                    .font(.system(size: 30))
                    .frame(maxWidth: 85)
                
            }
            .padding(.horizontal)
            .frame(width: 390, height: 90)
            .background(Color.black)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
        }
}


struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(temp: 76, date: "Wednesday, September 24", weatherImage: "sun.max.fill").environmentObject(WeatherViewModel())
    }
}
