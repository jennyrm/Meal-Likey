//
//  UserController.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    var currentUser: User = User(username: "Jenny", userID: "30B9DA82-4103-4DF8-B944-B125C3B70163")
    
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
    
    func getUserData() {
        DatabaseManager.shared.getUserData { result in
            switch result {
            case .success(let user):
                print(user)
                self.currentUser = user
            case .failure(let error):
                print("Error in \(#function): on line \(#line) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
}
