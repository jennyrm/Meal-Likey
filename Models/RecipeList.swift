//
//  RecipeList.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import Foundation

struct RecipeList: Codable, Hashable {
    let name: String
    let thumbnailUrl: String?
    let videoUrl: String?
    let description: String?
    let numServings: Int?
    let userRatings: UserRating?
    let nutrition: Nutrition?
    let instructions: [Instruction]?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", thumbnailUrl = "thumbnail_url", videoUrl = "video_url", description = "description", numServings = "num_servings", userRatings = "user_ratings", nutrition = "nutrition", instructions = "instructions"
    }
}
