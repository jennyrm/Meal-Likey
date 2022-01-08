//
//  UserController.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    let currentUser = User(username: "Jenny")
    
    func isAlreadyFavorited(_ recipe: Recipe) -> Bool {
        if let index = currentUser.favoritedRecipes.firstIndex(where: { $0 == recipe }) {
            let recipeToCompare = currentUser.favoritedRecipes[index]
            if recipe.id == recipeToCompare.id {
                return true
            }
        }
        return false
    }
    
    func addToFavorites(_ recipe: Recipe) {
//        guard let currentUser = currentUser else { return }
        currentUser.favoritedRecipes.append(recipe)
//        print(currentUser.favoritedRecipes)
    }
    
    func removeFromFavorites(_ recipe: Recipe) {
        if let recipeIndex = currentUser.favoritedRecipes.firstIndex(where: { $0 == recipe }) {
            currentUser.favoritedRecipes.remove(at: recipeIndex)
//            print(currentUser.favoritedRecipes)
        }
    }
    
    func fetchUserFavorites() -> [Recipe] {
        return currentUser.favoritedRecipes
    }
    
}
