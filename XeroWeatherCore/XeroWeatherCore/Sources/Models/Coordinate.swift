//
//  Coordinate.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/29/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public struct Coordinate: Codable {
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
    
    public let longitude: Double
    public let latitude: Double
    
    public init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}

extension Coordinate: Equatable {
    public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}
