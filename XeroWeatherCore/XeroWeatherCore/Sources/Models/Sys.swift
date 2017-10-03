//
//  Sys.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public struct Sys: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case message
        case country
        case sunriseValue = "sunrise"
        case sunsetValue = "sunset"
    }
    
    public let type: Int?
    public let id: Int?
    public let message: Double?
    public let country: String?
    public let sunriseValue: Int?
    public let sunsetValue: Int?
}
