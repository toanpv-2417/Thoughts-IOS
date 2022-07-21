//
//  APICaller.swift
//  Thoughts
//
//  Created by Pham Toan on 22/07/2022.
//

import Foundation

struct Constants {
    static let APIKEY = "32cadf4facb9e665094041a65d96c14a"
    static let baseURL = "https://api.themoviedb.org/"
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (String)-> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.APIKEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data,_,error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("LOG: \(results)")
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
        
        task.resume()
    }
}
