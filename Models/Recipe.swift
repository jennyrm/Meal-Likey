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
    var name: String
    var thumbnailUrl: String?
    var description: String?
    var numServings: Int?
    var recipes: [RecipeListItem]?
    var userRatings: UserRating?
    var nutrition: Nutrition?
    var sections: [RecipeComponent]?
    var instructions: [Instruction]?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", thumbnailUrl = "thumbnail_url", description = "description", numServings = "num_servings", recipes = "recipes", userRatings = "user_ratings", nutrition = "nutrition", sections = "sections", instructions = "instructions"
    }
    
    //some json objects do not have a recipes property, so this is needed to check against that
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        numServings = try container.decodeIfPresent(Int.self, forKey: .numServings)
        recipes = try container.decodeIfPresent(Array.self, forKey: .recipes)
        userRatings = try container.decodeIfPresent(UserRating.self, forKey: .userRatings)
        nutrition = try container.decodeIfPresent(Nutrition.self, forKey: .nutrition)
        sections = try container.decodeIfPresent(Array.self, forKey: .sections)
        instructions = try container.decodeIfPresent(Array.self, forKey: .instructions)
    }
    
    init(name: String, thumbnailUrl: String, description: String, numServings: Int, recipes: [RecipeListItem]?, userRatings: UserRating, nutrition: Nutrition, sections: [RecipeComponent], instructions: [Instruction]) {
        self.name = name
        self.thumbnailUrl = thumbnailUrl
        self.description = description
        self.numServings = numServings
        self.recipes = recipes
        self.userRatings = userRatings
        self.nutrition = nutrition
        self.sections = sections
        self.instructions = instructions
    }
    
}//End of class

//extension Recipe: Hashable {
//    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
//        return lhs.name == rhs.name && lhs.thumbnailUrl == rhs.thumbnailUrl && lhs.description == rhs.description && lhs.numServings == rhs.numServings && lhs.recipes == rhs.recipes && lhs.userRatings == rhs.userRatings && lhs.nutrition == rhs.nutrition && lhs.sections == rhs.sections && lhs.instructions == rhs.instructions
//    }
//}
