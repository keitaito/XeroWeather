//
//  TestHelper.swift
//  XeroWeatherCoreTests
//
//  Created by Keita Ito on 10/1/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

struct TestHelper {
    func loadJSON(name: String) -> Data? {
        // Load JSON file from the unit test bundle.
        
        let nameComponents = Array(name.split(separator: "."))
        let fileName = String(nameComponents.first!)
        let typeName = String(nameComponents.last!)
        
        guard let jsonPath = Bundle(for: CurrentWeatherTests.self).path(forResource: fileName, ofType: typeName) else {
            print("jsonPath is nil.")
            return nil
        }
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            print("jsonData is nil.")
            return nil
        }
        
        return jsonData
    }
}
