//
//  Nutrition.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import Foundation

struct Nutrition: Codable, Hashable {
    let protein: Int?
    let fat: Int?
    let calories: Int?
    let sugar: Int?
    let carbohydrates: Int?
    let fiber: Int?
}
