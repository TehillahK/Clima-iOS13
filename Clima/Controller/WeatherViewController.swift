//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherLogic = WeatherLogic()
    
    let coreLocation = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.searchTextField.delegate = self
        self.weatherLogic.delegate = self
        self.coreLocation.delegate = self
        
        self.coreLocation.requestWhenInUseAuthorization()
        self.coreLocation.requestLocation()
    }

    @IBAction func searchBtnPressed(_ sender: UIButton) {
        weatherLogic.getWeatherInfo(city: searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    @IBAction func currLocationBtnPressed(_ sender: UIButton) {
        
        self.coreLocation.requestLocation()
    }
    
    
    
  
    
    
}


// MARK: - UI Text Delegate

extension WeatherViewController: UITextFieldDelegate{
    // runs if they press go or ok in on screen keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

}


// MARK: - UI Weather Manager Delegate

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(manager: WeatherLogic, weather: WeatherModel) {
       print(weather.conditionName)
        DispatchQueue.main.async {
            print(weather.temperature)
            self.cityLabel.text = weather.cityName
            
            self.temperatureLabel.text = String(format: "%.1f",weather.temperature)
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
        }
      //  cityLabel.text = weather.cityName
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
}


// MARK: - Location Services

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]){
        if let currLocation = didUpdateLocations.last{
            manager.stopUpdatingLocation()
            self.weatherLogic.getWeatherInfo(lat: currLocation.coordinate.latitude, long: currLocation.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
