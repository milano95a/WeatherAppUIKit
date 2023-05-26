//
//  WeatherViewModel.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import Foundation

protocol WeatherView: AnyObject {
    func setCurrentWeather(_ temperature: String, _ description: String)
    func dailyForecastUpdated()
}

class WeatherViewModel {
    
    // MARK: API(s)
    
    init(_ view: WeatherView) {
        self.view = view
        self.apiManager = APIManager()
        self.dbManager = DBManager()
    }
    
    private(set) var dailyForecast = [WeatherForecast]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view?.dailyForecastUpdated()
            }
        }
    }
    
    private(set) var currentWeather: CurrentWeatherResponse? {
        didSet {
            if let currentWeather {
                let temperature = String(currentWeather.main.temp).withDegrees
                let description = currentWeather.weather[0].main
                DispatchQueue.main.async { [weak self] in
                    self?.view?.setCurrentWeather(temperature, description)
                }
            }
        }
    }
    
    func load() {
        if Reachability.isConnectedToNetwork() {
            apiManager.getCurrentWeather { [weak self] data in
                self?.dbManager.setCurrentWeather(data)
                self?.currentWeather = data
            }
            apiManager.getWeatherForecasts { [weak self] forecasts in
                self?.dbManager.setWeatherForecasts(forecasts)
                self?.dailyForecast = self!.getDailyForecast(forecasts)
            }
        } else {
            dbManager.getCurrentWeather { [weak self] data in
                self?.currentWeather = data
            }
            dbManager.getWeatherForecasts { [weak self] forecasts in
                self?.dailyForecast = self!.getDailyForecast(forecasts)
            }
        }
    }
    
    // MARK: Private API(s)
    private weak var view: WeatherView?
    private let apiManager: APIManager
    private let dbManager: DBManager
    
    private func getDailyForecast(_ forecasts: [WeatherForecast]) -> [WeatherForecast] {
        var dailyForecast = [WeatherForecast]()
        for (index,forecast) in forecasts.enumerated() {
            if index == 0 {
                dailyForecast.append(forecast)
            }
            if let date1 = dailyForecast.last?.dt_txt.getDate(), let date2 = forecast.dt_txt.getDate() {
                if !Calendar.current.isDate(date1, inSameDayAs: date2) {
                    dailyForecast.append(forecast)
                }
            }
        }
        return dailyForecast
    }
}
