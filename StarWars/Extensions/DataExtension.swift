//
//  Data+Extension.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-26.
//

import Foundation

// Helper to retrieve the right string value for base64 API uploaders
extension Data {
  func asBase64Param(withType type: MimeType = .jpeg) -> String {
    "data:\(type.rawValue);base64,\(self.base64EncodedString())"
  }
}
