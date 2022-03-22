//
//  ImageDownloader.swift
//  
//
//  Created by Paul Wong on 3/19/22.
//

import Foundation
import UIKit

public enum ImageError: Error {
  case requestFailed(Error)
  case imageParsingFailed
}

public struct ImageDownloader {
  static public func getImage(withURL url: URL,
                              completion: ((Result<UIImage, ImageError>) -> Void)? = nil) -> URLSessionDataTask {
    let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion?(.failure(.requestFailed(error)))
      } else {
        if let data = data,
           let image = UIImage(data: data) {
          completion?(.success(image))
        } else {
          completion?(.failure(.imageParsingFailed))
        }
      }
    }
    dataTask.resume()
    return dataTask
  }
}
