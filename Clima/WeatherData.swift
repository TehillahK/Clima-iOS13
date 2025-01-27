//
//  Weather.swift
//  Clima
//
//  Created by Tehillah Kangamba on 2025-01-26.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
   
}

struct Clouds: Codable {
    let all: Int
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
   
}


struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

