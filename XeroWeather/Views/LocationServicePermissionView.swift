//
//  LocationServicePermissionView.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/5/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import UIKit

protocol LocationServicePermissionViewDelegate: class {
    func didSelectPermissionButton(_ sender: LocationServicePermissionView)
}

class LocationServicePermissionView: UIView {
    
    weak var delegate: LocationServicePermissionViewDelegate?
    
    let persmissionButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(persmissionButton)
        
        persmissionButton.setTitle("Check weather at your locaiton", for: .normal)
        persmissionButton.backgroundColor = self.tintColor
        persmissionButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        persmissionButton.addTarget(self, action: #selector(foo), for: .touchUpInside)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        persmissionButton.layer.cornerRadius = persmissionButton.frame.size.height / 2
        persmissionButton.clipsToBounds = true
        persmissionButton.sizeToFit()
    }
    
    private func setupLayout() {
        print("***** setupLayout *****")
        
        persmissionButton.translatesAutoresizingMaskIntoConstraints = false
        persmissionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        persmissionButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        persmissionButton.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        safeAreaLayoutGuide.trailingAnchor.constraint(greaterThanOrEqualTo: persmissionButton.trailingAnchor, constant: 20).isActive = true
        
        print("***** setupLayout *****")
    }
    
    @objc private func foo() {
        delegate?.didSelectPermissionButton(self)
    }
}
