//
//  StarwarsEndpoint.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-26.
//

import Foundation

internal enum StartwarsEndpoint: Endpoint {
    
    case planets(String?)
    
    var baseURL: String {
        "https://swapi.dev/api/"
    }
    
    var requestURL: URL {
//        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
//            fatalError("URL for endpoint at \(path) could not be constructed")
//        }
        
        guard let url = URL(string: "\(baseURL)\(path)") else {
            fatalError("URL for endpoint at \(path) could not be constructed")
        }
        
        print("url: \(url.absoluteString)")
        
        return url
    }
    
    var path: String {
        switch self {
        case .planets(let page):
            return page == nil ? "planets" : "planets/?page=\(page!)"
        }
    }
    
    var method: Network.HTTPMethod {
        switch self {
        case .planets:
            return .get
        }
    }
    
}
