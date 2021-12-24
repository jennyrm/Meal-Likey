//
//  DatabaseManager.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/19/21.
//

import Foundation
import FirebaseFirestore

class DatabaseManager {
    
    //MARK: - Singleton
    static let shared = DatabaseManager()
    
    //MARK: - DB
    let db = Firestore.firestore()
    
    //MARK: - Properties
    let currentUser = UserController.shared.currentUser
    
    //MARK: - Saving Data
    func saveUserData() {
        var favoritedRecipes = [String]()
        
        for recipe in currentUser.favoritedRecipes {
            favoritedRecipes.append(recipe.recipeID)
            createDBRecipeObject(recipe)
        }
        
        let usersRef = db.collection(StringConstants.users).document(currentUser.userID)
        usersRef.setData(["username" : currentUser.username,
                          "userID" : currentUser.userID,
                          "favoritedRecipes" : favoritedRecipes,
                          "createdRecipes" : [""]
                         ])
    }
    
    func saveRecipe(recipeID: String, name: String, thumbnailUrl: String, description: String, numServings: Int, userRatings: [String : Int], nutrition: [String : Int], ingredients: [String], instructions: [String], isFavorited: Bool) {
        
        let favoritesRef = db.collection(StringConstants.recipes).document(recipeID)
        favoritesRef.setData(["name" : name,
                                 "thumbnailUrl" : thumbnailUrl,
                                 "numServings" : numServings,
                                 "userRatings" : userRatings,
                                 "nutrition" : nutrition,
                                 "ingredients" : ingredients,
                                 "instructions" : instructions,
                                 "isFavorited" : isFavorited,
                                 "recipeID" : recipeID
                                 ])
    }
    
    //MARK: - Fetching Data
    func fetchUserData() {
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
                        
                        self.getRecipes(for: favorited, completion: { result in
                            switch result {
                            case .success(let favoritedRecipes):
                                let createdRecipes = [Recipe(name: "", thumbnailUrl: "", description: "", numServings: 0, recipes: nil, userRatings: UserRating(score: 0.0, countPositive: 0, countNegative: 0), nutrition: Nutrition(carbohydrates: 0, fiber: 0, protein: 0, fat: 0, calories: 0, sugar: 0), sections: [RecipeComponent(components: [Ingredient(rawText: "")])], instructions: [Instruction(displayText: "")])]
                                
                                let user = User(username: username, favoritedRecipes: favoritedRecipes, createdRecipes: createdRecipes, userID: userID)
                                print("user:", user.favoritedRecipes)
                            case .failure(let error):
                                print("Error in \(#function): on line \(#line) : \(error.localizedDescription) \n---\n \(error)")
                            }
                        })
                        
//                        for index in user.favoritedRecipes {
//                            print(index.nutrition)
//                            print(index.nutrition.calories)
//                        }
                    }
                }
            }
    }
    
    func getRecipes(for collection: [String], completion: @escaping (Result<[Recipe], MLError>) -> Void) {
        var recipes = [Recipe]()
        
        for recipeID in collection {
            db.collection(StringConstants.recipes).whereField("recipeID", isEqualTo: recipeID)
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
                            
                            let recipe = self.convertDocumentToRecipeObject(name: name, thumbnailUrl: thumbnailUrl, description: "", numServings: numServings, userRatings: userRatings, nutrition: nutrition, ingredients: ingredients, instructions: instructions, isFavorited: isFavorited)
                            
                            recipes.append(recipe)
//                            print(recipes)
                        }
                    }
                    completion(.success(recipes))
                }
        }
    }
    
    //MARK: - Helper Functions
    func createDBRecipeObject(_ recipe: Recipe) {
        let recipeID = recipe.recipeID, name = recipe.name, thumbnailUrl = recipe.thumbnailUrl, description = recipe.description, numServings = recipe.numServings, isFavorited = recipe.isFavorited
        
        var userRatingsDict = [String : Int]()
        var nutritionDict = [String : Int]()
    
        userRatingsDict["score"] = Int(recipe.userRatings.score!)
        userRatingsDict["countPositive"] = recipe.userRatings.countPositive
        userRatingsDict["countNegative"] = recipe.userRatings.countNegative
        
        nutritionDict["carbohydrates"] = recipe.nutrition.carbohydrates
        nutritionDict["fiber"] = recipe.nutrition.fiber
        nutritionDict["protein"] = recipe.nutrition.protein
        nutritionDict["fat"] = recipe.nutrition.fat
        nutritionDict["calories"] = recipe.nutrition.calories
        nutritionDict["sugar"] = recipe.nutrition.sugar
        
        let ingredientsArr = recipe.sections.first?.components.map { $0.rawText } ?? []
        
        let instructionsArr = recipe.instructions.map { $0.displayText }
        
        saveRecipe(recipeID: recipeID, name: name, thumbnailUrl: thumbnailUrl, description: description, numServings: numServings, userRatings: userRatingsDict, nutrition: nutritionDict, ingredients: ingredientsArr, instructions: instructionsArr, isFavorited: isFavorited)
    }
    
    func convertDocumentToRecipeObject(name: String, thumbnailUrl: String, description: String, numServings: Int, userRatings: [String : Int], nutrition: [String : Int], ingredients: [String], instructions: [String], isFavorited: Bool) -> Recipe {
        
        let userRatingsObj = UserRating(score: Double(userRatings["score"]!), countPositive: userRatings["countPositive"], countNegative: userRatings["countNegative"])
        
        let nutritionObj = Nutrition(carbohydrates: nutrition["carbohydrates"], fiber: nutrition["fiber"], protein: nutrition["protein"], fat: nutrition["fat"], calories: nutrition["calories"], sugar: nutrition["sugar"])
        
        let ingredientsObj = ingredients.map { Ingredient(rawText: $0) }
        let recipeComponent = RecipeComponent(components: ingredientsObj)
        
        let instructionsObj = instructions.map { Instruction(displayText: $0) }
        
        let recipe = Recipe(name: name, thumbnailUrl: thumbnailUrl, description: "", numServings: numServings, recipes: nil, userRatings: userRatingsObj, nutrition: nutritionObj, sections: [recipeComponent], instructions: instructionsObj, isFavorited: isFavorited)

        return recipe
    }
    
}
