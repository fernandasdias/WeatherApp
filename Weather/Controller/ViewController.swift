//
//  ViewController.swift
//  Weather
//
//  Created by Fernanda Dias on 24/04/20.
//  Copyright © 2020 Fernanda Dias. All rights reserved.
//
// colors #AD9191 #E5E5E5 #000000  #D8D8D8 
import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

//MARK: - UITextFieldDelegate Section

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
        return true
        }
        else {
            textField.placeholder = "Type Something"
        return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate Section

extension ViewController: WeatherManagerDelegate
{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
          DispatchQueue.main.async {
              let grausString = "ºC"
              self.temperatureLabel.text = weather.temperatureString + grausString
              self.conditionImageView.image = UIImage(systemName: weather.conditionName)
         
          }
      }
      
      func didFailWithError(error: Error) {
          print(error)
      }
}

