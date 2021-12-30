//
//  RecipeController.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/9/21.
//

import Foundation

class RecipeController {
    
    static let shared = RecipeController()
    
    func createRecipeObject(from recipeListItem: RecipeListItem) -> Recipe {
        let recipe = Recipe(
                                name: recipeListItem.name,
                                id: recipeListItem.id,
                                thumbnailUrl: recipeListItem.thumbnailUrl ?? "",
                                description: recipeListItem.description ?? "",
                                numServings: recipeListItem.numServings ?? 0,
                                recipes: nil,
                                userRatings: recipeListItem.userRatings ?? UserRating(score: nil, countPositive: nil, countNegative: nil),
                                nutrition: recipeListItem.nutrition ?? Nutrition(carbohydrates: nil, fiber: nil, protein: nil, fat: nil, calories: nil, sugar: nil),
                                sections: recipeListItem.sections ?? [],
                                instructions: recipeListItem.instructions ?? []
                               )
        
        return recipe
    }
    
}
