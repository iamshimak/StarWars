//
//  GetPlanetsResponse.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-25.
//

import UIKit

class GetPlanetsResponse: NSObject, Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PlanetResponse]
}

class PlanetResponse: NSObject, Codable {
    let climate: String
    let name: String
    let orbital_period: String
    let gravity: String
}
