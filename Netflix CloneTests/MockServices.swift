//
//  MockAPICaller.swift
//  Netflix CloneTests
//
//  Created by Olanrewaju Olakunle  on 02/07/2023.
//

import Foundation
import UIKit


class MockAPICaller: NetworkService, ImageCachingService {
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let image = ImageCache.shared.cache.object(forKey: url.absoluteString as NSString){
          print("using cached images")
          completion(image)
          return
        }
         
        guard let url = URL(string: "\(url)") else {
          completion(NetworkError.badUrl as? UIImage)
          return
        }
         
        print("Fetching images")
         
        let task = URLSession.shared.dataTask(with: url){ data, _, error in
        
          guard let data = data, error == nil else {
            completion(NetworkError.unsupportedImage as? UIImage)
            return
          }
           
          DispatchQueue.main.async {
            guard let image = UIImage(data: data) else {
              completion(nil)
              return
            }
              ImageCache.shared.cache.setObject(image, forKey: url.absoluteString as NSString)
            completion(image)
          }
           
        }
        task.resume()
      }
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        //Mocking the GetTrendingMovies method an invalid URL to force a failure
        let invalidURL = URL(string: "https://example.com")!
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: invalidURL)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        // Modifying the URL to an invalid one to trigger a failure
        let invalidURL = URL(string: "https://example.com/invalid-url")!
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: invalidURL)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedTogetData))
            }
        }
        task.resume()
    }
    
}
