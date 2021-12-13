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
    
    func addToFavorites(_ recipe: Recipe) {
//        guard let currentUser = currentUser else { return }
        currentUser.favoriteRecipes.append(recipe)
    }
}
