//
//  FindAPIResultTests.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import XCTest
import XeroWeatherCore

class FindAPIResultTests: XCTestCase {
    func testDecodingFindAPIResult() {
        // given
        let json = TestHelper().loadJSON(name: "find.json")!
        
        do {
            let result = try JSONDecoder().decode(FindAPIResult.self, from: json)
            XCTAssertEqual(result.list.first!.cityName, "San Francisco")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
