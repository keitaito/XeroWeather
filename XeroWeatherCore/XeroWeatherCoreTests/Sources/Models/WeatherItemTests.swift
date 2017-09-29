//
//  WeatherItemTests.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import XCTest
import XeroWeatherCore

class WeatherItemTests: XCTestCase {
    func testWeatherItemInit() {
        // given
        let givenCityName = "San Francisco County"
        let givenCoordinate = Coordinate(longitude: -122.45, latitude: 37.77)
        
        // Load JSON file from the unit test bundle.
        guard let jsonPath = Bundle(for: type(of: self)).path(forResource: "current-weather-by-city-id", ofType: "json") else {
            XCTFail("jsonPath is nil."); return
        }
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            XCTFail("jsonData is nil."); return
        }
        
        // when
        do {
            let weather = try JSONDecoder().decode(WeatherItem.self, from: jsonData)
            
            // then
            XCTAssertEqual(weather.cityName, givenCityName)
            XCTAssertEqual(weather.coordinate, givenCoordinate)
            
        } catch {
            XCTFail(error.localizedDescription); return
        }
    }
    
     
}
