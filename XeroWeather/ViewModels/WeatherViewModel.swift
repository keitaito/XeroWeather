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
    var forecast: Forecast?
    
    init(location: CLLocation) {
        self.location = location
    }
    
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> Void) {
        weatherAPI.load(resource) { (object) in
            completion(object)
        }
    }
    
    func resource<T: Codable>(url: URL, parameters: Resource<T>.Parameters) -> Resource<T> {
        return Resource<T>(url: url, method: .get, parameters: parameters, headers: nil, parse: { json in
            do {
                return try JSONDecoder().decode(T.self, from: json)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        })
    }
}

// MARK: - Methods and Computed Properties for forecastCollectionView

extension WeatherViewModel {
    var forecastWeatherIemCount: Int {
        return forecast?.list.count ?? 0
    }
    
    func forecastWeatherItem(at indexPath: IndexPath) -> WeatherItem? {
        guard indexPath.item <= forecastWeatherIemCount else { return nil }
        guard let forecast = forecast else { return nil }
        return forecast.list[indexPath.item]
    }
}
