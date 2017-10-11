//
//  WeatherViewModel.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/10/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation
import CoreLocation
import XeroWeatherCore

class WeatherViewModel {
    let weatherAPI = WeatherAPI()
    
    let location: CLLocation
    var weather: CurrentWeather?
    
    init(location: CLLocation) {
        self.location = location
    }
    
    func load<A>(resource: Resource<A>, completion: @escaping (A) -> Void) {
        weatherAPI.load(resource) { (object) in
            guard let object = object else { return }
            completion(object)
        }
    }
    
    func currentWeatherResource(url: URL, parameters: Resource<CurrentWeather>.Parameters) -> Resource<CurrentWeather> {
        return Resource<CurrentWeather>(url: url, method: .get, parameters: parameters, headers: nil, parse: { json in
            do {
                return try JSONDecoder().decode(CurrentWeather.self, from: json)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        })
    }
}
