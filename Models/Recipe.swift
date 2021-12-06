//
//  Recipe.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import Foundation

//hash is how it figures out if the data needs to change
struct TopLevelObject: Codable, Hashable {
    //why struct for object model?
    //why must all classes conform to hashable
    let count: Int
    let results: [Recipe]
}

struct Recipe: Codable, Hashable {
    let name: String
    let thumbnailUrl: String?
    let description: String?
    let numServings: Int?
    let recipes: [RecipeList]?
    let userRatings: UserRating?
    let nutrition: Nutrition?
    let instructions: [Instruction]?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", thumbnailUrl = "thumbnail_url", description = "description", numServings = "num_servings", recipes = "recipes", userRatings = "user_ratings", nutrition = "nutrition", instructions = "instructions"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        numServings = try container.decodeIfPresent(Int.self, forKey: .numServings)
        recipes = try container.decodeIfPresent(Array.self, forKey: .recipes)
        userRatings = try container.decodeIfPresent(UserRating.self, forKey: .userRatings)
        nutrition = try container.decodeIfPresent(Nutrition.self, forKey: .nutrition)
        instructions = try container.decodeIfPresent(Array.self, forKey: .instructions)
    }
}
