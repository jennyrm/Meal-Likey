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
    private let headers = [
        "X-RapidAPI-Host": "tasty.p.rapidapi.com",
        "X-RapidAPI-Key": "da15175627msh92545092087f045p1ac653jsnc254cceec242"
    ]
    
    //make a private init for singleton so that it can only be initialized here
    private init() {}
    
    func getRecipes(for recipe: String, completed: @escaping (Result<[Recipe], MLError>) -> Void) {
        
        let endpoint = baseURL
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
            
                let recipes = try decoder.decode([Recipe].self, from: data)
                
                //why no return?
                completed(.success(recipes))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
