//
//  ForecastCollectionViewCell.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/11/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import UIKit
import XeroWeatherCore

class ForecastCollectionViewCell: UICollectionViewCell {
    let temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with weatherItem: WeatherItem) {
        temperatureLabel.text = weatherItem.climate.tempStringInFahrenheit(.average)
    }
}
