//
//  WeatherView.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/11/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import UIKit
import XeroWeatherCore

class WeatherView: UIView {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let cityNameLabel = UILabel()
    let stateLabel = UILabel()
//    let iconImageView = UIImageView()
    
    let temperatureLabel = UILabel()
    let highTemperatureLabel = UILabel()
    let lowTemperatureLabel = UILabel()
    let highAndLowTempStackView = UIStackView()
    
    let forecastCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var flowLayout: UICollectionViewFlowLayout {
        return forecastCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        // Set constraints for scrollView.
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        // Set constraints for stackView.
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // Set attributes of stackView.
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        // Add subViews to stackVieww.
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(stateLabel)
        stackView.addArrangedSubview(temperatureLabel)
        
        highAndLowTempStackView.axis = .horizontal
        highAndLowTempStackView.spacing = 20
        highAndLowTempStackView.distribution = .fillEqually
        highAndLowTempStackView.addArrangedSubview(highTemperatureLabel)
        highAndLowTempStackView.addArrangedSubview(lowTemperatureLabel)
        stackView.addArrangedSubview(highAndLowTempStackView)
        
        // Set attributes of cityNameLabel.
        cityNameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        // Set up forecastCollectionView.
        flowLayout.scrollDirection = .horizontal
        stackView.addArrangedSubview(forecastCollectionView)
        forecastCollectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with currentWeather: CurrentWeather) {
        cityNameLabel.text = currentWeather.cityName
        stateLabel.text = currentWeather.weather.first?.state ?? "Unknown"
        temperatureLabel.text = currentWeather.climate.tempStringInFahrenheit(.average)
        highTemperatureLabel.text = currentWeather.climate.tempStringInFahrenheit(.high)
        lowTemperatureLabel.text = currentWeather.climate.tempStringInFahrenheit(.low)
    }
}
