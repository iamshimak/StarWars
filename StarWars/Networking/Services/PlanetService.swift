//
//  PlanetService.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-25.
//

import Foundation

final class PlanetService {
    
    class func getPlanets(
        page: String? = nil,
        completion: @escaping (Result<GetPlanetsResponse, Error>) -> Void
    ) {
        BaseAPIClient.default.request(
            endpoint: StartwarsEndpoint.planets(page)
        ) { (result: Result<GetPlanetsResponse?, Error>, _) in
            switch result {
            case .success(let response):
                guard let response = response else {
                    let planetsNotFoundError = App.error(
                        domain: .parsing,
                        localizedDescription: "Could not parse planets".localized
                    )
                    completion(.failure(planetsNotFoundError))
                    return
                }
                
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
