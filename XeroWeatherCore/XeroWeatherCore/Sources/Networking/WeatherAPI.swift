//
//  WeatherAPI.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation
import Alamofire

public class WeatherAPI {
    private let sessionManager: Alamofire.SessionManager
    
    public init(sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.sessionManager = Alamofire.SessionManager(configuration: sessionConfiguration)
    }
    
    public func load<A>(_ resource: Resource<A>, completion: @escaping (A?) -> Void) {
        // Convert my HTTPMethod to Alamofire's HTTPMethod.
        let af_method = Alamofire.HTTPMethod(rawValue: resource.method.rawValue) ?? Alamofire.HTTPMethod.get
        
        let defaultQueue = DispatchQueue.global(qos: .default)
        
        sessionManager.request(resource.url, method: af_method, parameters: resource.parameters, headers: resource.headers).responseData(queue: defaultQueue) { (dataResponse) in
            switch dataResponse.result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(nil)
            case .success(let data):
                completion(resource.parse(data))
            }
        }
    }
}
