//
//  APIManager.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import Foundation

struct APIManager {
    let baseURL = "https://api.openweathermap.org/data/2.5"
    let apiKey = "8b6a054d6baf6bc6ad2bad6c30b51648"
    let city = "Tashkent"
    
    func getCurrentWeather(_ completion: @escaping (CurrentWeatherResponse?) -> Void) {
        let urlString = "\(baseURL)/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("error: \(error!.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
                completion(json)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func getWeatherForecasts(_ completion: @escaping ([WeatherForecast]) -> Void) {
        let urlString = "\(baseURL)/forecast?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("error: \(error!.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(WeatherForecastResponse.self, from: data)
                completion(result.list)
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
            
        }.resume()
    }
}
