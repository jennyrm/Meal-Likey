//
//  UserController.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    let currentUser = User(username: "Jenny", userID: "1351E7C8-2B9F-4E69-BD56-20CCE692AFF3")
    
    func isAlreadyFavorited(_ recipe: Recipe) -> Bool {
        return currentUser.favoritedRecipes.contains(recipe)
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
