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
    
    private let baseURL = "https://tasty.p.rapidapi.com/"
    private let recipesListEndpoint = "recipes/list"
    private let headers = [
        "X-RapidAPI-Host": "tasty.p.rapidapi.com",
        "X-RapidAPI-Key": "a811ef2008mshbbf3ee1dc3019edp17f547jsna443ca249c84"
    ]
    
    //make a private init for singleton so that it can only be initialized here
    private init() {}
    
    func getRecipes(for recipe: String, from recipeValue: Int, completed: @escaping (Result<TopLevelObject, MLError>) -> Void) {
        
        guard let url = URL(string: baseURL + recipesListEndpoint) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let fromQuery = URLQueryItem(name: "from", value: String(recipeValue))
        let sizeQuery = URLQueryItem(name: "size", value: "40")
        let qQuery = URLQueryItem(name: "q", value: recipe)
        components?.queryItems = [fromQuery, sizeQuery, qQuery]
        
        guard let completeURL = components?.url else { return }
        
        var request = URLRequest(url: completeURL)
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
                let data = try decoder.decode(TopLevelObject.self, from: data)

                completed(.success(data))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}
