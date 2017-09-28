//
//  WeatherTests.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import XCTest

class WeatherTests: XCTestCase {
    func testWeatherInit() {
        // given
        let givenCityName = "San Fransokyo"
        
        // when
        let weather = Weather(cityName: givenCityName)
        
        // then
        XCTAssertEqual(weather.cityName, givenCityName)
    }
}
