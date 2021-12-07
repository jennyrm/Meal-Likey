//
//  Ingredient.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/7/21.
//

import Foundation

struct Ingredient: Codable, Hashable {
    let rawText: String
    
    enum CodingKeys: String, CodingKey {
        case rawText = "raw_text"
    }
}
