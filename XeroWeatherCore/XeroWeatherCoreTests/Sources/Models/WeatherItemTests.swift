//
//  CurrentWeatherTests.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import XCTest
import XeroWeatherCore

class CurrentWeatherTests: XCTestCase {
    
    // given
    let givenCityName = "San Francisco County"
    let givenCoordinate = Coordinate(longitude: -122.45, latitude: 37.77)
    
    func testCurrentWeatherInit() {
        // given
        let json = TestHelper().loadJSON(name: "current-weather-by-city-id.json")!
        
        // when
        do {
            let weather = try JSONDecoder().decode(CurrentWeather.self, from: json)
            
            // then
            XCTAssertEqual(weather.cityName, givenCityName)
            XCTAssertEqual(weather.coordinate, givenCoordinate)
            
        } catch {
            XCTFail(error.localizedDescription); return
        }
    }
}
