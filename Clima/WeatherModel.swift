//
//  WeatherModel.swift
//  Clima
//
//  Created by Tehillah Kangamba on 2025-01-26.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    // computed variable
    var conditionName: String{
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
        }
    }
}
