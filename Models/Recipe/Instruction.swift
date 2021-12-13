//
//  Instruction.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import Foundation

struct Instruction: Codable, Hashable {
    let displayText: String
    
    private enum CodingKeys: String, CodingKey {
        case displayText = "display_text"
    }
}
