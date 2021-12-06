//
//  UserRating.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import Foundation

struct UserRating: Codable, Hashable {
    let score: Double?
    let countPositive: Int?
    let countNegative: Int?
    
    private enum CodingKeys: String, CodingKey {
        case score = "score", countPositive = "count_positive", countNegative = "count_negative"
    }
}
