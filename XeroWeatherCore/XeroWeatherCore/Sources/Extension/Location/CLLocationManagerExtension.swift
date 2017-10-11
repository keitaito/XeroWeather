//
//  CLLocationManagerExtension.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 10/8/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationManager {
    public func checkLocationServiceAuthorization(status: CLAuthorizationStatus, errorHandler: @escaping (String) -> Void) {
        switch status {
        case .notDetermined:
            print("Location Service is not determined.")
            self.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location Service is available.")
            self.requestLocation()
        case .denied, .restricted:
            errorHandler("Location Service is not available.")
        }
    }
    
    public func requestLocation(errorHandler: @escaping (String) -> Void) {
        guard CLLocationManager.locationServicesEnabled() else {
            errorHandler("Location Service is not enabled.")
            return
        }
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            self.requestLocation()
        case .notDetermined:
            print("Location Service is not determined.")
            self.requestWhenInUseAuthorization()
        default:
            errorHandler("Location Service is not available.")
        }
    }
}
