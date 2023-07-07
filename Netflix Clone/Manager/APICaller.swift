//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Olanrewaju Olakunle  on 07/11/2022.
//

import Foundation

struct constants {
    
    static let API_Key = "347f77f16f797effad472e9445e850f4"
    static let baseURL = "https://api.themoviedb.org"
    static var YoutubeAPI_KEY = "AIzaSyAH1EgJ9E7ySeYhnnYw-M0sK5mI303vhro"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case FailedTogetData
}

protocol NetworkService{
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) ->Void)
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) ->Void)
}

class APICaller: NetworkService {
    
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let url = URL(string: "\(constants.baseURL)/3/trending/movie/day?api_key=\(constants.API_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
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
    
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let url = URL(string: "\(constants.baseURL)/3/trending/tv/day?api_key=\(constants.API_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
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
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let url = URL(string: "\(constants.baseURL)/3/movie/popular?api_key=\(constants.API_Key)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
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
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let url = URL(string: "\(constants.baseURL)/3/movie/upcoming?api_key=\(constants.API_Key)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
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
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let url = URL(string: "\(constants.baseURL)/3/movie/top_rated?api_key=\(constants.API_Key)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
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
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let url = URL(string: "\(constants.baseURL)/3/discover/movie?api_key=\(constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
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
    
    func search (with query: String, completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(constants.baseURL)/3/search/movie?api_key=\(constants.API_Key)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
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
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) ->Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(constants.YoutubeBaseURL)q=\(query)&key=\(constants.YoutubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                // print(results)
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
}
