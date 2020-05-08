//
//  WeatherModel.swift
//  Weather
//
//  Created by Fernanda Dias on 04/05/20.
//  Copyright © 2020 Fernanda Dias. All rights reserved.
//

import Foundation

class WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    var conditionName: String = ""
    var temperatureString: String = ""
    init(conditionId: Int, cityName: String, temperature: Double){
    
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
        self.conditionName = self.getConditionName(weatherId: conditionId)
        self.temperatureString = String(format: "%.1f", self.temperature)
    }
    
    func getConditionName(weatherId: Int) -> String {
        switch weatherId {
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
        default: return "cloud"
        }
    }
    
}
