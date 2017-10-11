//
//  CityTableViewController.swift
//  XeroWeather
//
//  Created by Keita Ito on 10/3/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import UIKit
import CoreLocation

class CityTableViewController: UITableViewController {
    
//    let locations: [CLLocation]
    let viewModel: CityTableViewModel
    
    init(viewModel: CityTableViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        let vc = WeatherViewController(location: viewModel.currentLocation)
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        if let location = viewModel.item(at: indexPath) {
            cell.textLabel?.text = String(describing: location.coordinate)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
}
