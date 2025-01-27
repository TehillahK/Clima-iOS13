//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherLogic = WeatherLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchTextField.delegate = self
        self.weatherLogic.delegate = self
    }

    @IBAction func searchBtnPressed(_ sender: UIButton) {
        weatherLogic.getWeatherInfo(city: searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
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
    
    func didUpdateWeather(manager: WeatherLogic, weather: WeatherModel) {
       print(weather.conditionName)
      //  cityLabel.text = weather.cityName
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
  
    
    
}

