//
//  Resource.swift
//  XeroWeatherCore
//
//  Created by Keita Ito on 9/27/17.
//  Copyright © 2017 Keita Ito. All rights reserved.
//

import Foundation

// Reference:
// https://talk.objc.io/episodes/S01E01-networking
// https://talk.objc.io/episodes/S01E08-networking-post-requests
public struct Resource<A> {
    public typealias Parameters = [String: Any]
    public typealias HTTPHeaders = [String: String]
    
    public let url: URL
    public let method: HTTPMethod
    public let parameters: Parameters?
    public let headers: HTTPHeaders?
    public let parse: (Data) -> A?
    
    public init(url: URL, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, parse: @escaping (Data) -> A?) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.parse = parse
    }
}

extension Resource {
    public init(url: URL, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data)
            return json.flatMap(parseJSON)
        }
    }
}
