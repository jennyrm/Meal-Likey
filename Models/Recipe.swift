//
//  Recipe.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/19/21.
//

import Foundation

struct Recipe: Codable, Hashable {
    let name: String
    let thumbnailUrl: String?
}
