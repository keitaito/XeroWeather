//
//  Weather.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/29/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public struct Weather: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case state = "main"
        case description
        case iconString = "icon"
    }
    
    public let id: Int
    public let state: String
    public let description: String
    public let iconString: String
}

extension Weather {
    public var iconURL: URL {
        return URL(string: "https://openweathermap.org/img/w/\(iconString).png")!
    }
}
