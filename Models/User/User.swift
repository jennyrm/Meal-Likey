//
//  User.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import UIKit

class User: Codable {
    
    let username: String
    var favoritedRecipes: [Recipe]
    var createdRecipes: [Recipe]
    let userID: String
    
    init(username: String, favoritedRecipes: [Recipe] = [], createdRecipes: [Recipe] = [], userID: String = UUID().uuidString) {
        self.username = username
        self.favoritedRecipes = favoritedRecipes
        self.createdRecipes = createdRecipes
        self.userID = userID
    }
    
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userID == rhs.userID
    }
}
