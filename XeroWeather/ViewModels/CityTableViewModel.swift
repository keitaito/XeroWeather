//
//  CityTableViewModel.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/9/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation
import CoreLocation
import XeroWeatherCore

enum CityTableViewSectionType: Int {
    case currentLocation
    case locations
}

extension CityTableViewSectionType {
    var title: String {
        switch self {
        case .currentLocation:
            return "Current Location"
        case .locations:
            return "Locations"
        }
    }
}

class CityTableViewModel {
    let currentLocation: CLLocation
    var locations = [CLLocation]()
    
    init(currentLocation: CLLocation) {
        self.currentLocation = currentLocation
    }
    
    var numberOfSections: Int {
        return 2
    }
    
    func itemCount(in section: Int) -> Int {
        guard let sectionType = CityTableViewSectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .currentLocation:
            return 1
        case .locations:
            return locations.count
        }
    }
    
    func item(at indexPath: IndexPath) -> CLLocation? {
        guard let sectionType = CityTableViewSectionType(rawValue: indexPath.section) else { return nil }
        
        switch sectionType {
        case .currentLocation:
            return currentLocation
        case .locations:
            guard indexPath.row <= locations.count else { return nil }
            return locations[indexPath.row]
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        guard let sectionType = CityTableViewSectionType(rawValue: section) else { return nil }
        return sectionType.title
    }
}
