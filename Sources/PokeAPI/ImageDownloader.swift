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
  static public func getImage(withURL url: URL) async throws(ImageError) -> UIImage {
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let image = UIImage(data: data) {
        return image
      } else {
        throw ImageError.imageParsingFailed
      }
    } catch let error as ImageError {
      throw error
    } catch {
      throw .requestFailed(error)
    }
  }
}
