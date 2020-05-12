//
//  WeatherManager.swift
//  Weather
//
//  Created by Fernanda Dias on 28/04/20.
//  Copyright © 2020 Fernanda Dias. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,   weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ec095f7c5300fffb89ef1fb61f56c62e&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    fileprivate func FormatCityWithTwoWords (_ cityName: String) -> String {
        return (cityName as NSString).replacingOccurrences(of: " ", with: "+")
    }
    
    func fetchWeather(cityName: String) {
        let cityNameFormatted = FormatCityWithTwoWords (cityName)
        
        let urlString = "\(weatherURL)&q=\(cityNameFormatted)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String)
    {
        //4 steps of networking
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //inside the closure, we have to add the word "self" if we are calling a function inside the class.
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?
    {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            //let description = decodedData.weather[0].description
            let name = decodedData.name
            let main = decodedData.weather[0].main
            let temp_min = decodedData.main.temp_min
            let temp_max = decodedData.main.temp_max
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, main: main, temp_min: temp_min, temp_max: temp_max)
            
         return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
     
    }
     
}
