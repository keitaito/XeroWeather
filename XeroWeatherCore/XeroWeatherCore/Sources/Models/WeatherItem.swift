//
//  WeatherItem.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public class WeatherItem: Codable {
    enum CodingKeys: String, CodingKey {
        case dateValue = "dt"
        case climate = "main"
        case weather
        case wind
        case clouds
    }
    
    public let dateValue: Int
    public let climate: Climate
    public let weather: [Weather]
    public let wind: Wind
    public let clouds: Clouds
}

extension WeatherItem {
    public var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateValue))
    }
}
