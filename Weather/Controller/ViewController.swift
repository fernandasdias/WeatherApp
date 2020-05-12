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
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func locationButtonPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
}


//MARK: - CLLocationManager Delegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
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
              self.cityLabel.text = weather.cityName
              self.statusLabel.text
                = weather.main
            self.minTemperatureLabel.text = weather.minTemperatureString
            self.maxTemperatureLabel.text = weather.maxTemperatureString
          }
      }
      
      func didFailWithError(error: Error) {
          print(error)
      }
}

