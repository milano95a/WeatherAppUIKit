//
//  WeatherDetailViewModel.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import Foundation

protocol WeatherDetailView: AnyObject {
    func setDate(_ date: String)
    func hourlyForecastsUpdated()
}

class WeatherDetailViewModel {
    
    // MARK: API(s)
    private(set) var hourlyForecasts = [WeatherForecast]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view?.hourlyForecastsUpdated()
            }
        }
    }
    
    init(_ view: WeatherDetailView) {
        self.view = view
        self.apiManager = APIManager()
        self.dbManager = DBManager()
    }
    
    func load(with date: Date) {
        if Reachability.isConnectedToNetwork() {
            apiManager.getWeatherForecasts { [weak self] forecasts in
                self?.dbManager.setWeatherForecasts(forecasts)
                self?.hourlyForecasts = self!.getHouryForecast(date, forecasts)
            }
        } else {
            dbManager.getWeatherForecasts { [weak self] forecasts in
                self?.hourlyForecasts = self!.getHouryForecast(date, forecasts)
            }
        }
        view?.setDate(date.getWeekdayString())
    }
    
    // MARK: Private API(s)
    private weak var view: WeatherDetailView?
    private let apiManager: APIManager
    private let dbManager: DBManager
    
    func getHouryForecast(_ date: Date, _ forecasts: [WeatherForecast]) -> [WeatherForecast] {
        var dailyForecast = [WeatherForecast]()
        for forecast in forecasts {
            if let date1 = forecast.dt_txt.getDate() {
                if Calendar.current.isDate(date1, inSameDayAs: date) {
                    dailyForecast.append(forecast)
                }
            }
        }
        return dailyForecast
    }
}

