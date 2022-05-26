//
//  Constants.swift
//  Starwars
//
//  Created by German Lopez on 3/29/16.
//  Copyright © 2016 Rootstrap Inc. All rights reserved.
//

import UIKit

struct App {
    static let domain = Bundle.main.bundleIdentifier ?? ""
    
    static var isValidOrientation: Bool {
        UIDevice.current.orientation.isValidInterfaceOrientation
    }
    
    static func error(
        domain: ErrorDomain = .generic, code: Int? = nil,
        localizedDescription: String = ""
    ) -> NSError {
        NSError(
            domain: App.domain + "." + domain.rawValue,
            code: code ?? 0,
            userInfo: [NSLocalizedDescriptionKey: localizedDescription]
        )
    }
    
    static func orientation() -> Orientation {
        switch UIDevice.current.orientation {
        case .unknown:
            return .portrait
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portrait
        case .landscapeLeft:
            return .landscape
        case .landscapeRight:
            return .landscape
        case .faceUp:
            return .portrait
        case .faceDown:
            return .portrait
        @unknown default:
            return .portrait
        }
    }
}

enum ErrorDomain: String {
    case generic = "GenericError"
    case parsing = "ParsingError"
    case network = "NetworkError"
}

enum Orientation: Equatable {
    case portrait, landscape
}
