//
//  WeatherLogic.swift
//  Clima
//
//  Created by Tehillah Kangamba on 2025-01-26.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
let env = ProcessInfo.processInfo.environment

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(manager: WeatherLogic,weather: WeatherModel)
    
    func didFailWithError(error: Error)
}

struct WeatherLogic{
    var city = ""
    let API_KEY = env["OPEN_WEATHER_API_KEY"] ?? "failed"
    var delegate: WeatherManagerDelegate?

    func getWeatherInfo(city: String){
      //  self.city = city
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)"
        
        let url = URL(string: apiUrl)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url! ,completionHandler: {
            (data: Data?, response:URLResponse?, error:Error? ) in
            if(error != nil){
                print(error!)
                self.delegate?.didFailWithError(error:error! )
                return
            }
            
            if let safeData = data{
               // let dataString = String(data: safeData, encoding: .utf8)
               let weatherData = self.parseJson(safeData)
                
                if let safeWeatherModel = weatherData{
                    let weather = createWeatherModel(safeWeatherModel)
                    self.delegate?.didUpdateWeather(manager: self,weather: weather)
                }
            }
        })
        
        task.resume()
        
        
    }
    
    func parseJson(_ jsonString: Data) -> WeatherData?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: jsonString)
           // print("temp\(decodedData.main.temp)")
            return decodedData
            
        }catch{
            print("PARSE Error:\(error)")
            self.delegate?.didFailWithError(error:error )
            return nil
        }
        
    }
    
    func createWeatherModel(_ weatherData: WeatherData) -> WeatherModel{
       // var result: WeatherModel? = nil
        
        return WeatherModel(conditionID: weatherData.weather[0].id, cityName: weatherData.name, temperature: weatherData.main.temp)
        
    }
    
    

}
