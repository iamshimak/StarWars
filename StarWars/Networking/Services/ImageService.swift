//
//  ImageService.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-26.
//

import UIKit

final class ImageService {
        
    class func downloadImage(
        url: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        BaseAPIClient.default.download(url: url) { (result: Result<Data?, Error>, _) in
            switch result {
            case .success(let response):
                guard let response = response, let image = UIImage(data: response) else {
                    let planetsNotFoundError = App.error(
                        domain: .parsing,
                        localizedDescription: "Could not parse image".localized
                    )
                    completion(.failure(planetsNotFoundError))
                    return
                }
                
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
