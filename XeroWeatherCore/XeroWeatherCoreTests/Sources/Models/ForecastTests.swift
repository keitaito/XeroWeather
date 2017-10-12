//
//  ForecastTests.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import XCTest
import XeroWeatherCore

class ForecastTests: XCTestCase {
    func testInitWithFiveDayWeatherForecast() {
        // given
        let givenCityName = "San Francisco County"
        let json = TestHelper().loadJSON(name: "five-day-weather-forecast.json")!
        
        // when; then
        do {
            let forecast = try JSONDecoder().decode(Forecast.self, from: json)
            XCTAssertEqual(forecast.city.name, givenCityName)
        } catch let DecodingError.dataCorrupted(context) {
            XCTFail("dataCorrupted(context): \(context)")
        } catch let DecodingError.keyNotFound(key, context) {
            XCTFail("keyNotFound(key, context): \(key), \(context)")
        } catch let DecodingError.typeMismatch(type, context) {
            XCTFail("typeMismatch(type, context): \(type), \(context)")
        } catch let DecodingError.valueNotFound(type, context) {
            XCTFail("valueNotFound(type, context): \(type), \(context)")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
