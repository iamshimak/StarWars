//
//  UIImageView+Extension.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-25.
//

import UIKit

import Alamofire
import RxSwift
import SkeletonView

extension UIImageView {
    public func load(from url: String) {
        showAnimatedGradientSkeleton()
        ImageService.downloadImage(url: url) { [weak self] (result: Result<UIImage, Error>) in
            self?.hideSkeleton()
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
