//
//  WeatherItem.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public class WeatherItem: Codable {
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case coordinate = "coord"
        case conditions = "weather"
        case climate = "main"
        case wind
        case dateValue = "dt"
        case id
    }
    
    public let cityName: String
    public let coordinate: Coordinate
    public let conditions: [Condition]
    public let climate: Climate
    public let wind: Wind
    public let dateValue: Int
    public let id: Int
    
    public init(cityName: String, coordinate: Coordinate, conditions: [Condition], climate: Climate, wind: Wind, dateValue: Int, id: Int) {
        self.cityName = cityName
        self.coordinate = coordinate
        self.conditions = conditions
        self.climate = climate
        self.wind = wind
        self.dateValue = dateValue
        self.id = id
    }
}

extension WeatherItem: CustomStringConvertible {
    public var description: String {
        return "<\(type(of: self)) cityName: \(cityName), coordinate: \(coordinate)>"
    }
}

extension WeatherItem {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateValue))
    }
}
