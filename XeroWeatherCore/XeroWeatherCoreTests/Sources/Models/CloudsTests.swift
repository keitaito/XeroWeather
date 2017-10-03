//
//  CloudsTests.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import XCTest
import XeroWeatherCore

class CloudsTests: XCTestCase {
    
    func testDecodingClouds() {
        // given
        let expected = 20
        
        let json = """
            { "all": 20 }
        """.data(using: .utf8)!
        
        // when; then
        do {
            let clouds = try JSONDecoder().decode(Clouds.self, from: json)
            XCTAssertEqual(clouds.value, expected)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
