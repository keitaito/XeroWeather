//
//  ForecastDateFormatter.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/12/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public class ForecastDateFormatter {
    public static let shared = ForecastDateFormatter()
    
    private let dateFormatter = DateFormatter()
    
    public init() {
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E h a"
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
    }
    
    public func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
