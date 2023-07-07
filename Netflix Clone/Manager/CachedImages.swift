//
//  cachedImages.swift
//  Netflix Clone
//
//  Created by Olanrewaju Olakunle  on 29/05/2023.
//

import Foundation
import UIKit

enum NetworkError: Error {
  case badRequest
  case unsupportedImage
  case badUrl
}

protocol ImageCachingService {
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void)
}

class ImageCache: ImageCachingService{
  static let shared = ImageCache()
   
  public let cache = NSCache<NSString, UIImage>()
   
  public init(){}

  public func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void){
     
    if let image = cache.object(forKey: url.absoluteString as NSString){
      print("using cached images")
      completion(image)
      return
    }
     
    guard let url = URL(string: "\(url)") else {
      completion(NetworkError.badUrl as? UIImage)
      return
    }
     
    print("Fetching images")
     
    let task = URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
      /*
      guard let error = error else {
        completion(nil)
        return
      }*/
       
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        completion(NetworkError.badRequest as! UIImage?)
        return
      }
       
      guard let data = data, error == nil else {
        completion(NetworkError.unsupportedImage as? UIImage)
        return
      }
       
      DispatchQueue.main.async {
        guard let image = UIImage(data: data) else {
          completion(nil)
          return
        }
        self?.cache.setObject(image, forKey: url.absoluteString as NSString)
        completion(image)
      }
       
    }
    task.resume()
  }
   
}

/*
 //
 //  cachedImages.swift
 //  Netflix Clone
 //
 //  Created by Olanrewaju Olakunle  on 29/05/2023.
 //

 import Foundation
 import UIKit

 enum NetworkError: Error {
     case badRequest
     case unsupportedImage
     case badUrl
 }

 enum CacheError: Error {
     case FailedTogetData
 }

 class ImageCache{
     static let shared = ImageCache()
     
     private let cache = NSCache<NSString, NSData>()
     
     private init(){}
     
     public func fetchImage(url: URL, completion: @escaping (Data?, Error?) -> Void){
         
         if let image = cache.object(forKey: url.absoluteString as NSString){
             print("using cached images")
             completion(image as Data, nil)
             return
         }
         
         guard let url = URL(string: "\(url)") else {
             completion(nil, NetworkError.badUrl)
             return
         }
         
         let task = URLSession.shared.downloadTask(with: url) { [weak self] localUrl, response, error in
             
             guard let error = error else {
                 completion(nil, error)
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                 completion(nil, NetworkError.badRequest)
                 return
             }
             
             guard let localUrl = localUrl else {
                 completion(nil, NetworkError.unsupportedImage)
                 return
             }
             
             DispatchQueue.main.async {
                 
                 do {
                     let image = try Data(contentsOf: localUrl)
                     self?.cache.setObject(image as NSData, forKey: url.absoluteString as NSString)
                     completion(image, nil)
                 } catch let error {
                     completion(nil, error)
                 }
             }
         }
         task.resume()
     }
     
 }

*/
