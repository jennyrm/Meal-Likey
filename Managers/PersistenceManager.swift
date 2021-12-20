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
        
        let usersRef = db.collection(StringConstants.users).document(currentUser.userID)
        usersRef.setData(["username" : currentUser.username,
                             "userID" : currentUser.userID,
                             "favoritedRecipes" : favoritedRecipes,
                             "createdRecipes" : [""]
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
        
        let favoritesRef = db.collection(StringConstants.recipes).document(recipe.recipeID)
        favoritesRef.setData(["name" : recipe.name,
                                 "thumbnailUrl" : recipe.thumbnailUrl,
                                 "numServings" : recipe.numServings,
                                 "userRatings" : userRatingsDict,
                                 "nutrition" : nutritionDict,
                                 "ingredients" : ingredientsArr,
                                 "instructions" : instructionsArr,
                                 "isFavorited" : recipe.isFavorited,
                                 ])
    }
    
    func fetchUser() {
        db.collection(StringConstants.users).whereField("userID", isEqualTo: currentUser.userID)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print(error)
                } else {
                    for doc in querySnapshot!.documents {
                        let userData = doc.data()
                        let username = userData["username"] as! String
                        let favorited = userData["favoritedRecipes"] as! [String]
                        let created = userData["createdRecipes"] as! [String]
                        let userID = userData["userID"] as! String
                        
                        let favoritedRecipes = self.fetchRecipes(favorited)
                        let createdRecipes = self.fetchRecipes(created)
                        
                        let user = User(username: username, favoritedRecipes: favoritedRecipes, createdRecipes: createdRecipes, userID: userID)
                        print("user:", user)
                    }
                }
            }
    }
    
    func fetchRecipes(_ array: [String]) -> [Recipe] {
        var recipes = [Recipe]()
        
        array.forEach {
            db.collection(StringConstants.recipes).whereField("recipeID", isEqualTo: $0)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        print(error)
                    } else {
                        for doc in querySnapshot!.documents {
                            let recipeData = doc.data()
                            let name = recipeData["name"] as! String
                            let thumbnailUrl = recipeData["thumbnailUrl"] as! String
                            let numServings = recipeData["numServings"] as! Int
                            let userRatings = recipeData["userRatings"] as! [String : Int]
                            let nutrition = recipeData["nutrition"] as! [String : Int]
                            let ingredients = recipeData["ingredients"] as! [String]
                            let instructions = recipeData["instructions"] as! [String]
                            let isFavorited = recipeData["isFavorited"] as! Bool
                            
                            let userRatings1 = UserRating(score: Double(userRatings["score"]!), countPositive: userRatings["countPositive"], countNegative: userRatings["countNegative"])
                            
                            let nutrition1 = Nutrition(carbohydrates: nutrition["carbohydrates"], fiber: nutrition["fiber"], protein: nutrition["protein"], fat: nutrition["fat"], calories: nutrition["calories"], sugar: nutrition["sugar"])
                            
                            var ingredients1 = [Ingredient]()
                            ingredients.forEach {
                                ingredients1.append(Ingredient(rawText: $0))
                            }
                            var recipeComponent = RecipeComponent(components: ingredients1)
                            
                            var instructions1 = [Instruction]()
                            instructions.forEach {
                                instructions1.append(Instruction(displayText: $0))
                            }
                            
                            let recipe = Recipe(name: name, thumbnailUrl: thumbnailUrl, description: "", numServings: numServings, recipes: nil, userRatings: userRatings1, nutrition: nutrition1, sections: [recipeComponent], instructions: instructions1, isFavorited: isFavorited)
                            
                            recipes.append(recipe)
                        }
                        
                    }
                }
        }
        
        return recipes
    }
    
    func convertDBObjectToRecipeObject() {
        
    }
    
}

