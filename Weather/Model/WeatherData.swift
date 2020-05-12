//
//  WeatherData.swift
//  Weather
//
//  Created by Fernanda Dias on 30/04/20.
//  Copyright © 2020 Fernanda Dias. All rights reserved.
//

import Foundation

class WeatherData: Codable    {
    let name: String
    let main: Main
    let weather:[Weather]
}

class Main:Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

class Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
}
