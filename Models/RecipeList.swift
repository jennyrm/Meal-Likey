//
//  RecipeList.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/1/21.
//

import Foundation

struct TopLevelObject: Codable, Hashable {
    //why struct for object model?
    let results: [RecipeList]
}

struct RecipeList: Codable, Hashable {
    let name: String
    let thumbnailUrl: String?
    let recipes: [Recipe]?
}
