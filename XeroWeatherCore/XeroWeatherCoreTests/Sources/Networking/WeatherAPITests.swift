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
    
    let givenName = "San Francisco County"
    
    let api = WeatherAPI()
    let defaultParameters: Resource.Parameters = ["id": 5391997,
                                           "appid": "e80b662e177680f3e0e730ba8e469c9d"]
    
    func testAPICurrentWeather() {
        let e = expectation(description: "testAPICurrentWeather()")
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
        
        let resource = Resource<CurrentWeather>(url: url, method: .get, parameters: defaultParameters, headers: nil, parse: { json in
            do {
                return try JSONDecoder().decode(CurrentWeather.self, from: json)
            } catch {
                XCTFail(error.localizedDescription)
                return nil
            }
        })
        
        api.load(resource) { (weather) in
            guard let weather = weather else { XCTFail("weather is nil."); return }
            print(weather)
            XCTAssertEqual(weather.cityName, self.givenName)
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            error.map { XCTFail($0.localizedDescription); return }
        }
    }
    
    func testAPIFiveDayForecast() {
        let e = expectation(description: "testAPIFiveDayForecast()")
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
        let resource = Resource<Forecast>(url: url, method: .get, parameters: defaultParameters, headers: nil, parse: { json in
            do {
                return try JSONDecoder().decode(Forecast.self, from: json)
            } catch {
                XCTFail(error.localizedDescription)
                return nil
            }
        })
        
        api.load(resource) { (forecast) in
            XCTAssertEqual(forecast?.city.name, self.givenName)
            e.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            error.map { XCTFail($0.localizedDescription); return }
        }
    }
    
    func testAPIFind() {
        let e = expectation(description: "testAPIFind()")
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/find")!
        let parameters = ["q": "San Francisco",
                          "type": "like",
                          "appid": "e80b662e177680f3e0e730ba8e469c9d"]
        let expectedName = "San Francisco"
        
        let resource = Resource<FindAPIResult>(url: url, method: .get, parameters: parameters, headers: nil, parse: { json in
            do {
                return try JSONDecoder().decode(FindAPIResult.self, from: json)
            } catch {
                XCTFail(error.localizedDescription)
                return nil
            }
        })
        
        api.load(resource) { (result) in
            XCTAssertEqual(result?.list.first?.cityName, expectedName)
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            error.map { XCTFail($0.localizedDescription); return }
        }
    }
}
