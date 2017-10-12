//
//  Constants.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/10/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public let kAppId = "e80b662e177680f3e0e730ba8e469c9d"

public struct WeatherAPIParameter {
    public static let appid = "appid"
    public static let latitude = "lat"
    public static let longitude = "lon"
    public static let cityId = "id"
}

public struct WeatherAPIEndpoint {
    public static let currentWeather = "https://api.openweathermap.org/data/2.5/weather"
    public static let forecast = "https://api.openweathermap.org/data/2.5/forecast"
}
