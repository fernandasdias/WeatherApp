//
//  WeatherData.swift
//  Weather
//
//  Created by Fernanda Dias on 30/04/20.
//  Copyright © 2020 Fernanda Dias. All rights reserved.
//

import Foundation

class WeatherData: Decodable {
    let name: String
    let main: Main
    let weather:[Weather]
}

class Main:Decodable {
    let temp: Double
}

class Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
}
