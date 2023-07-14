//
//  ContentView.swift
//  Weather
//
//  Created by Mollie Whaley on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        ZStack {
            Color.black
            
            TabView {
                CurrentWeatherView()
                    .environmentObject(weatherVM)
                    .tabItem {
                        Text("Today")
                    }
                    .toolbarBackground(Color.black, for: .tabBar)
                
                ForecastView()
                    .environmentObject(weatherVM)
                    .tabItem {
                        Text("Next 4")
                    }
                    .toolbarBackground(Color.black, for: .tabBar)
            }
            .accentColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
