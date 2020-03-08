//
//  DataProvider.swift
//  notes
//
//  Created by Pavel Anpleenko on 08/12/2019.
//  Copyright © 2019 Pavel Anpleenko. All rights reserved.
//

import Foundation
import UIKit

class DataProvider {
  private init() {}
  
  static let shared = DataProvider()
  
  var imageCache = NSCache<NSString, UIImage>()
  
  func downloadImageInCache(url: String, completion: @escaping (UIImage) -> Void) {
    
    guard let url = URL(string: url) else { return }
    
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
      completion(cachedImage)
    } else {
      let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
      let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
          guard let image =  UIImage(data: data) else {return}
          self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
          DispatchQueue.main.async {
            completion(image)
          }
        }
      }
      dataTask.resume()
    }
  }
}
