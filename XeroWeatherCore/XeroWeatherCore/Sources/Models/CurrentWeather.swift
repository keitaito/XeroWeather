//
//  CurrentWeather.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public class CurrentWeather: Codable {
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case coordinate = "coord"
        case weather = "weather"
        case climate = "main"
        case wind
        case clouds
        case dateValue = "dt"
        case id
        case sys
    }
    
    public let cityName: String
    public let coordinate: Coordinate
    public let weather: [Weather]
    public let climate: Climate
    public let wind: Wind
    public let clouds: Clouds
    public let dateValue: Int
    public let id: Int
    public let sys: Sys
    
    public init(cityName: String, coordinate: Coordinate, weather: [Weather], climate: Climate, wind: Wind, clouds: Clouds, dateValue: Int, id: Int, sys: Sys) {
        self.cityName = cityName
        self.coordinate = coordinate
        self.weather = weather
        self.climate = climate
        self.wind = wind
        self.clouds = clouds
        self.dateValue = dateValue
        self.id = id
        self.sys = sys
    }
}

extension CurrentWeather: CustomStringConvertible {
    public var description: String {
        return "<\(type(of: self)) cityName: \(cityName), coordinate: \(coordinate), weather: \(weather), climate: \(climate), wind: \(wind), clouds: \(clouds), date: \(date), id: \(id)>"
    }
}

extension CurrentWeather {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateValue))
    }
}
