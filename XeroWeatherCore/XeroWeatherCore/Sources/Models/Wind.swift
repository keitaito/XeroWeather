//
//  Wind.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/29/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public struct Wind: Codable {
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
        case gust
    }
    
    public let speed: Double
    public let degree: Double?
    public let gust: Double?
}
