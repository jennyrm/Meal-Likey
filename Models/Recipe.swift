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
    let results: [Recipe]
}

struct Recipe: Codable, Hashable {
    let name: String
    let thumbnailUrl: String?
    let description: String?
    let recipes: [RecipeList]?
}
