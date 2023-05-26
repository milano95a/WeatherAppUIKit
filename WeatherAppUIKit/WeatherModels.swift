//
//  WeatherModels.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    var weather: [Description]
    var main: Weather
}

struct Description: Codable {
    var id: Int
    var main: String
}

struct Weather: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}

struct WeatherForecastResponse: Codable {
    var list: [WeatherForecast]
}

struct WeatherForecast: Codable {
    var weather: [Description]
    var main: Weather
    var dt_txt: String
}
