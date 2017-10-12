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
    let stackView = UIStackView()
    let dateLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set constraints for stackView.
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        // Set attributes of stackView.
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(temperatureLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with weatherItem: WeatherItem) {
        let forecastDateFormatter = ForecastDateFormatter.shared
        dateLabel.text = forecastDateFormatter.string(from: weatherItem.date)
        temperatureLabel.text = weatherItem.climate.tempStringInFahrenheit(.average)
    }
}
