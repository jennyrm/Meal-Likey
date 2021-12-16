//
//  PersistenceManager.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import Foundation
import FirebaseFirestore

class PersistenceManager {
    
    static let shared = PersistenceManager()
    let db = Firestore.firestore()
    let currentUser = UserController.shared.currentUser
    
    func saveUserData() {
        var favoritedRecipes = [String]()
        
        for recipe in currentUser.favoritedRecipes {
            favoritedRecipes.append(recipe.recipeID)
            createRecipeObjectForDB(recipe)
        }
        
        let usersRef = db.collection(StringConstants.Users).document(currentUser.userID)
        usersRef.setData(["username" : currentUser.username,
                             "userID" : currentUser.userID,
                             "favoritedRecipes" : favoritedRecipes
                             ])
    }
    
    func createRecipeObjectForDB(_ recipe: Recipe) {
        var userRatingsDict = [String : Int]()
        var nutritionDict = [String : Int]()
        var ingredientsArr = [String]()
        var instructionsArr = [String]()
        
        userRatingsDict["score"] = Int(recipe.userRatings.score!)
        userRatingsDict["countPositive"] = recipe.userRatings.countPositive
        userRatingsDict["countNegative"] = recipe.userRatings.countNegative
        
        nutritionDict["carbohydrates"] = recipe.nutrition.carbohydrates
        nutritionDict["fiber"] = recipe.nutrition.fiber
        nutritionDict["protein"] = recipe.nutrition.protein
        nutritionDict["fat"] = recipe.nutrition.fat
        nutritionDict["calories"] = recipe.nutrition.calories
        nutritionDict["sugar"] = recipe.nutrition.sugar
        
        for recipeComponent in recipe.sections {
            for ingredient in recipeComponent.components {
                ingredientsArr.append(ingredient.rawText)
            }
        }
        
        for instruction in recipe.instructions {
            instructionsArr.append(instruction.displayText)
        }
        
        let favoritesRef = db.collection(StringConstants.Recipes).document(recipe.recipeID)
        favoritesRef.setData(["name" : recipe.name,
                                 "thumbnailUrl" : recipe.thumbnailUrl,
                                 "numServings" : recipe.numServings,
                                 "userRatings" : userRatingsDict,
                                 "nutrition" : nutritionDict,
                                 "ingredients" : ingredientsArr,
                                 "instructions" : instructionsArr,
                                 "isFavorited" : recipe.isFavorited
                                 ])
    }
    
    func fetchUser(with userID: String) {
        db.collection(StringConstants.Users).whereField("userID", isEqualTo: userID)
    }
    
    func fetchRecipe(_ recipeID: String) {
         
    }
    
}

