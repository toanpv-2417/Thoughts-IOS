//
//  APICaller.swift
//  Thoughts
//
//  Created by Pham Toan on 22/07/2022.
//

import Foundation

struct Constants {
    static let APIKEY = "32cadf4facb9e665094041a65d96c14a"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError : Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.APIKEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data,_,error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)

                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
            
        }
        
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Tv],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.APIKEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTvResponse.self, from: data)

                completion(.success(results.results))
                print(results.results[0])
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=32cadf4facb9e665094041a65d96c14a&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
}
