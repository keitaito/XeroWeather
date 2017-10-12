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
        
        weatherView.forecastCollectionView.delegate = self
        weatherView.forecastCollectionView.dataSource = self
        weatherView.forecastCollectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ForecastCollectionViewCell.self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissVC))
        
        getCurrentWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func getCurrentWeather() {
        let url = URL(string: WeatherAPIEndpoint.currentWeather)!
        let parameters: Resource.Parameters = [WeatherAPIParameter.latitude: viewModel.location.coordinate.latitude,
                                               WeatherAPIParameter.longitude: viewModel.location.coordinate.longitude,
                                               WeatherAPIParameter.appid: kAppId]
        let resource: Resource<CurrentWeather> = viewModel.resource(url: url, parameters: parameters)
        viewModel.load(resource: resource) { [weak self] (currentWeather) in
            guard let strongSelf = self else { return }
            guard let currentWeather = currentWeather else { return }
            
            DispatchQueue.main.async {
                strongSelf.viewModel.weather = currentWeather
                strongSelf.getForecast()
                print(currentWeather)
                strongSelf.weatherView.configure(with: currentWeather)
            }
        }
    }
    
    private func getForecast() {
        guard let cityId = viewModel.weather?.id else { return }
        
        let url = URL(string: WeatherAPIEndpoint.forecast)!
        let parameters: Resource.Parameters = [WeatherAPIParameter.cityId: cityId,
                                                         WeatherAPIParameter.appid: kAppId]
        let resource: Resource<Forecast> = viewModel.resource(url: url, parameters: parameters)
        viewModel.load(resource: resource) { [weak self] (forecast) in
            guard let strongSelf = self else { return }
            guard let forecast = forecast else { return }
            print(forecast)
            
            DispatchQueue.main.async {
                strongSelf.viewModel.forecast = forecast
                strongSelf.weatherView.forecastCollectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.forecastWeatherIemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherView.forecastCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ForecastCollectionViewCell.self), for: indexPath) as! ForecastCollectionViewCell
        
        if let weatherItem = viewModel.forecastWeatherItem(at: indexPath) {
            print(weatherItem.climate.tempStringInFahrenheit(.average))
            cell.configure(with: weatherItem)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
}
