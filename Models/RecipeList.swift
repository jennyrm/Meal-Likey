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
//    let userRatings: UserRating
//    let numServings: Int?
//    let yields: String?
//    let nutrition: Nutrition
//    let instructions: [Instruction]
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", thumbnailUrl = "thumbnail_url", videoUrl = "video_url", description = "description"
    }
}
