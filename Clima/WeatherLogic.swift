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

    func getWeatherInfo(city: String){
      //  self.city = city
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)"
        
        let url = URL(string: apiUrl)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url! ,completionHandler: {
            (data: Data?, response:URLResponse?, error:Error? ) in
            if(error != nil){
                print(error!)
                return
            }
            
            if let safeData = data{
               // let dataString = String(data: safeData, encoding: .utf8)
                self.parseJson(safeData)
            }
        })
        
        task.resume()
        
        
    }
    
    func parseJson(_ jsonString: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: jsonString)
            print("temp\(decodedData.main.temp)")
        }catch{
            print(error)
        }
        
    }
    
    

}
