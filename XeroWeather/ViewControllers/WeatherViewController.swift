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
    
    var weatherView: WeatherView {
        return view as! WeatherView
    }
    
    init(location: CLLocation) {
        self.viewModel = WeatherViewModel(location: location)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        view = WeatherView(frame: view.frame)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissVC))
        
        let url = URL(string: WeatherAPIEndpoint.currentWeather)!
        let parameters: Resource.Parameters = [WeatherAPIParameter.latitude: viewModel.location.coordinate.latitude,
                                               WeatherAPIParameter.longitude: viewModel.location.coordinate.longitude,
                                               WeatherAPIParameter.appid: kAppId]
        let resource = viewModel.currentWeatherResource(url: url, parameters: parameters)
        viewModel.load(resource: resource) { [weak self] (currentWeather) in
            guard let currentWeather = currentWeather else { return }
            
            DispatchQueue.main.async {
                print(currentWeather)
                self?.weatherView.configure(with: currentWeather)
                
                if self?.viewModel.weather != nil {
                    self?.getForecast()
                }
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
        guard let cityId = viewModel.weather?.id else { return }
        
        let url = URL(string: WeatherAPIEndpoint.forecast)!
        let parameters: Resource.Parameters = [WeatherAPIParameter.cityId: cityId,
                                                         WeatherAPIParameter.appid: kAppId]
        let resource: Resource<Forecast> = viewModel.resource(url: url, parameters: parameters)
        viewModel.load(resource: resource) { (forecast) in
            guard let forecast = forecast else { return }
            
            print(forecast)
            print("breakpoint")
        }
    }
}
