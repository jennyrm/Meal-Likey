//
//  NetworkManager.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/18/21.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private let baseURL = "https://tasty.p.rapidapi.com/recipes/list"
    private let headers = [
        "X-RapidAPI-Host": "tasty.p.rapidapi.com",
        "X-RapidAPI-Key": "da15175627msh92545092087f045p1ac653jsnc254cceec242"
    ]
    
    //make a private init for singleton so that it can only be initialized here
    private init() {}
    
    func getRecipes(for recipe: String, completed: @escaping (Result<TopLevelObject, MLError>) -> Void) {
        
        let endpoint = URL(string: baseURL)
        var components = URLComponents(url: endpoint!, resolvingAgainstBaseURL: true)
        let fromQuery = URLQueryItem(name: "from", value: "0")
        let sizeQuery = URLQueryItem(name: "size", value: "20")
        let qQuery = URLQueryItem(name: "q", value: recipe)
        components?.queryItems = [fromQuery, sizeQuery, qQuery]
        
        guard let url = components?.url else { return }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //if let vs guard?
            if let error = error {
                print("Error in \(#function): on line \(#line) : \(error.localizedDescription) \n---\n \(error)")
                return completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completed(.failure(.invalidResponse))
            }
            
            guard let data = data else {
                return completed(.failure(.invalidData))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            
                let data = try decoder.decode(TopLevelObject.self, from: data)

                completed(.success(data))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
