//
//  WeatherManager.swift
//  Weather
//
//  Created by Fernanda Dias on 28/04/20.
//  Copyright © 2020 Fernanda Dias. All rights reserved.
//

import Foundation

class WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ec095f7c5300fffb89ef1fb61f56c62e&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String)
    {
        //4 steps of networking
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
}
