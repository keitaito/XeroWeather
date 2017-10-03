//
//  City.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public struct City: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case coordinate = "coord"
    }
    
    public let id: Int
    public let name: String
    public let coordinate: Coordinate
    public let country: String
}
