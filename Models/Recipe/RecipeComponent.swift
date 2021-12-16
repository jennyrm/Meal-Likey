//
//  RecipeComponent.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/7/21.
//

import Foundation

struct RecipeComponent: Codable, Hashable {
    let name: String?
    let components: [Ingredient]
}
