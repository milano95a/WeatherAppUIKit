//
//  DBManager.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import Foundation

struct DBManager {
    
    // MARK: API(s)
    
    func setCurrentWeather(_ data: CurrentWeatherResponse?) {
        writeData("currentWeather", data)
    }
    
    func getCurrentWeather(_ completion: (CurrentWeatherResponse) -> Void) {
        let currentWeather: CurrentWeatherResponse? = readData("currentWeather")
        if let currentWeather {
            completion(currentWeather)
        }
    }
    
    func setWeatherForecasts(_ data: [WeatherForecast]) {
        writeData("forecasts", data)
    }
    
    func getWeatherForecasts(_ completion: ([WeatherForecast]) -> Void) {
        let forecasts: [WeatherForecast]? = readData("forecasts")
        if let forecasts {
            completion(forecasts)
        }
    }
    
    // MARK: Private API(s)
    
    private func writeData<T>(_ fileName: String, _ data: T) where T: Codable {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("\(fileName).json")
            
            try JSONEncoder()
                .encode(data)
                .write(to: fileURL)
        } catch {
            print("error writing data")
        }
    }
    
    private func readData<T>(_ fileName: String) -> T? where T: Codable {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("\(fileName).json")
            
            let data = try Data(contentsOf: fileURL)
            let pastData = try JSONDecoder().decode(T.self, from: data)
            
            return pastData
        } catch {
            print("error reading data")
            return nil
        }
    }
}
