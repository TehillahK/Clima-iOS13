//
//  WeatherLogic.swift
//  Clima
//
//  Created by Tehillah Kangamba on 2025-01-26.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
let env = ProcessInfo.processInfo.environment
struct WeatherLogic{
    var city = ""
    let API_KEY = env["OPEN_WEATHER_API_KEY"] ?? "failed"

    mutating func getWeatherInfo(city: String){
        self.city = city
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)"
        
        print(apiUrl)
    }
    
}
