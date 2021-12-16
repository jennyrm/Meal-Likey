//
//  Recipe.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import Foundation

class Recipe: Codable {
    
    var name: String
    var thumbnailUrl: String
    var description: String
    var numServings: Int
    var recipes: [RecipeListItem]?
    var userRatings: UserRating
    var nutrition: Nutrition
    var sections: [RecipeComponent]
    var instructions: [Instruction]
    var isFavorited: Bool
    var recipeID: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", thumbnailUrl = "thumbnail_url", description = "description", numServings = "num_servings", recipes = "recipes", userRatings = "user_ratings", nutrition = "nutrition", sections = "sections", instructions = "instructions", isFavorited = "isFavorited", recipeID = "recipeID"
    }
    
    //some json objects do not have a recipes property, so this is needed to check against that
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        numServings = try container.decodeIfPresent(Int.self, forKey: .numServings) ?? 0
        recipes = try container.decodeIfPresent(Array.self, forKey: .recipes)
        userRatings = try container.decodeIfPresent(UserRating.self, forKey: .userRatings) ?? UserRating(score: nil, countPositive: nil, countNegative: nil)
        nutrition = try container.decodeIfPresent(Nutrition.self, forKey: .nutrition) ?? Nutrition(carbohydrates: nil, fiber: nil, protein: nil, fat: nil, calories: nil, sugar: nil)
        sections = try container.decodeIfPresent(Array.self, forKey: .sections) ?? []
        instructions = try container.decodeIfPresent(Array.self, forKey: .instructions) ?? []
        isFavorited = try container.decodeIfPresent(Bool.self, forKey: .isFavorited) ?? false
        recipeID = try container.decodeIfPresent(String.self, forKey: .isFavorited) ?? UUID().uuidString
    }
    
    init(name: String, thumbnailUrl: String, description: String, numServings: Int, recipes: [RecipeListItem]?, userRatings: UserRating, nutrition: Nutrition, sections: [RecipeComponent], instructions: [Instruction], isFavorited: Bool = false, recipeID: String = UUID().uuidString) {
        self.name = name
        self.thumbnailUrl = thumbnailUrl
        self.description = description
        self.numServings = numServings
        self.recipes = recipes
        self.userRatings = userRatings
        self.nutrition = nutrition
        self.sections = sections
        self.instructions = instructions
        self.isFavorited = isFavorited
        self.recipeID = recipeID
    }
    
}//End of class

//structs have an automatic hashable synthesizer?
extension Recipe: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.thumbnailUrl)
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.recipeID == rhs.recipeID
    }
}
