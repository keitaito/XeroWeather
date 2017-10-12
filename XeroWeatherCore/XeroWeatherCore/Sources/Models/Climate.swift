//
//  Climate.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/29/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public struct Climate: Codable {
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
    }
    
    public let temperature: Double
    public let pressure: Double
    public let humidity: Int
    public let minTemperature: Double
    public let maxTemperature: Double
}

extension Climate {
    public enum TempType {
        case average
        case high
        case low
    }
    
    public func tempInCelsius(_ tempType: TempType) -> Double {
        let temp: Double
        switch tempType {
        case .average:
            temp = temperature
        case .high:
            temp = maxTemperature
        case .low:
            temp = minTemperature
        }
        return temp - 273.15
    }
    
    public func tempInFahrenheit(_ tempType: TempType) -> Double {
        return tempInCelsius(tempType) * 1.8 + 32
    }
    
    public func tempStringInFahrenheit(_ tempType: TempType) -> String {
        return String(format: "%.0f°F", tempInFahrenheit(tempType))
    }
}
