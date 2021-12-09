//
//  RecipeController.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/9/21.
//

import Foundation

class RecipeController {
    
    static let sharedInstance = RecipeController()
    
    func createRecipeObject(from recipeListItem: RecipeListItem) -> Recipe {
        //jennyrm - FIX
        let recipe = Recipe(name: recipeListItem.name, thumbnailUrl: recipeListItem.thumbnailUrl! , description: recipeListItem.description ?? "", numServings: recipeListItem.numServings ?? 0, recipes: nil, userRatings: recipeListItem.userRatings!, nutrition: recipeListItem.nutrition!, sections: recipeListItem.sections ?? [], instructions: recipeListItem.instructions ?? [])
        
        return recipe
    }
    
}
