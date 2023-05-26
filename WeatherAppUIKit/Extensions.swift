//
//  Extensions.swift
//  WeatherAppUIKit
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 26/05/23.
//

import Foundation

extension Date {
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func getWeekdayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Monday
        return formatter.string(from: self)
    }
}

extension String {
    var withDegrees: String {
        return "\(self)°"
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}
