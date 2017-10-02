//
//  Clouds.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

public struct Clouds: Codable {
    enum CodingKeys: String, CodingKey {
        case value = "all"
    }
    
    public let value: Int
}
