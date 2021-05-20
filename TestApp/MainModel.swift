//
//  MainModel.swift
//  TestApp
//
//  Created by Hadi Faturrahman on 20/05/21.
//

import Foundation

struct WeatherModel: Codable {
    enum CodingKeys: String, CodingKey {
        case weather, main
    }
    let weather: [Weather]
    let main: MainWeather
}

struct MainWeather: Codable {
    enum CodingKeys: String, CodingKey {
        case temp
    }
    
    let temp: Double?
}

struct Weather: Codable {
    enum CodingKeys: String, CodingKey {
        case description
        case main
    }
    
    let main: WeatherGroup?
    let description: String?
}

enum WeatherGroup: String, Codable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case clear = "Clear"
    case clouds = "Clouds"
}
