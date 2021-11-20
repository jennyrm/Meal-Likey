//
//  Recipe.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/19/21.
//

import Foundation

struct Recipe: Codable {
    //why struct for object model?
    let name: String
    let description: String?
}
