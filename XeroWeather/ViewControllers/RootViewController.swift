//
//  RootViewController.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/3/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import UIKit
import CoreLocation
import XeroWeatherCore

class RootViewController: UIViewController {
    
    private var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation? {
        didSet {
            createCityTVC()
        }
    }
    private lazy var errorHandler: (String) -> Void = { [weak self] errorMessage in
        guard let strongSelf = self else { return }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            strongSelf.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    strongSelf.dismiss(animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location Service is available.")
            
            view.addSubview(spinner)
            spinner.center = view.center
            spinner.startAnimating()
            
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestLocation(errorHandler: errorHandler)
        default:
            let permissionView = LocationServicePermissionView(frame: view.bounds)
            permissionView.delegate = self
            view = permissionView
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Current Location", style: .plain, target: self, action: #selector(foo))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(bar))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func foo() {
        print("foo")
    }
    
    @objc private func bar() {
        
        guard childViewControllers.isEmpty else {
            print("childVCs exist already: \(childViewControllers)")
            return
        }
        
    }
    
    private func createCityTVC() {
        guard let currentLocation = currentLocation else { return }
        
        let cityTVM = CityTableViewModel(currentLocation: currentLocation)
        let cityTVC = CityTableViewController(viewModel: cityTVM)
        addChildViewController(cityTVC)
        cityTVC.view.frame = view.frame
        view.addSubview(cityTVC.view)
        cityTVC.didMove(toParentViewController: self)
    }
    
    private func createModalCurrentWeatherVC() {
    }
}

// MARK: - CLLocationManagerDelegate

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.startAnimating()
        
        manager.checkLocationServiceAuthorization(status: status, errorHandler: errorHandler)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
        
        guard let location = locations.last else {
            errorHandler("No CLLocation object in locations.")
            return
        }
        print(location)
        currentLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorHandler(error.localizedDescription)
    }
}

// MARK: - LocationServicePermissionViewDelegate

extension RootViewController: LocationServicePermissionViewDelegate {
    func didSelectPermissionButton(_ sender: LocationServicePermissionView) {
        guard CLLocationManager.locationServicesEnabled() else {
            errorHandler("Location Service is not enabled.")
            return
        }
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
    }
}
