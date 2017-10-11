//
//  WeatherViewController.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/9/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import UIKit
import CoreLocation
import XeroWeatherCore

class WeatherViewController: UIViewController {
    
    let viewModel: WeatherViewModel
    let label = UILabel()
    
    init(location: CLLocation) {
        self.viewModel = WeatherViewModel(location: location)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        label.text = String(describing: viewModel.location)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissVC))
        
        let url = URL(string: WeatherAPIEndpoint.currentWeather)!
        let parameters: Resource.Parameters = [
            WeatherAPIParameter.latitude: viewModel.location.coordinate.latitude,
            WeatherAPIParameter.longitude: viewModel.location.coordinate.longitude,
            WeatherAPIParameter.appid: kAppId]
        let resource = viewModel.currentWeatherResource(url: url, parameters: parameters)
        viewModel.load(resource: resource) { [weak self] (currentWeather) in
            DispatchQueue.main.async {
                self?.label.text = currentWeather.cityName
                print(currentWeather)
                
//                self?.getForecast()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func getForecast() {
//        let url
//        let parameters
    }
}
