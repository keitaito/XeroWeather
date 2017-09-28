//
//  WeatherAPITests.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import XCTest
import XeroWeatherCore

class WeatherAPITests: XCTestCase {
    
    let api = WeatherAPI()
    
    func testWeatherAPI() {
        
        let e = expectation(description: "testWeatherAPI()")
        
        let givenName = "San Francisco County"
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
        let parameters: Resource.Parameters = ["id": 5391997,
                                               "appid": "e80b662e177680f3e0e730ba8e469c9d"]
        
        let resource = Resource<Weather>(url: url, method: .get, parameters: parameters, headers: nil, parseJSON: { json in
            guard let json = json as? [String: Any],
                let name = json["name"] as? String else { return nil }
            
            return Weather(cityName: name)
        })
        
        api.load(resource) { (weather) in
            guard let weather = weather else { XCTFail("weather is nil."); return }
            XCTAssertEqual(weather.cityName, givenName)
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            error.map { XCTFail($0.localizedDescription); return }
        }
    }
}
