//
//  FindAPIResult.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public class FindAPIResult: Codable {
    public let list: [CurrentWeather]
}
