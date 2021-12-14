//
//  UserController.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import Foundation

class UserController {
    
    static let sharedInstance = UserController()
    
    let currentUser = User(username: "Jenny")
    
    func isAlreadyFavorited(_ recipe: Recipe) -> Bool {
        return currentUser.favoriteRecipes.contains(recipe)
    }
    
    func addToFavorites(_ recipe: Recipe) {
//        guard let currentUser = currentUser else { return }
        currentUser.favoriteRecipes.append(recipe)
        print(currentUser.favoriteRecipes)
    }
    
    func removeFromFavorites(_ recipe: Recipe) {
        if let recipeIndex = currentUser.favoriteRecipes.firstIndex(where: { $0 == recipe }) {
            currentUser.favoriteRecipes.remove(at: recipeIndex)
            print(currentUser.favoriteRecipes)
        }
    }
    
}
