//
//  PersistenceManager.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import Foundation
import FirebaseFirestore

class PersistenceManager {
    
    static let shared = PersistenceManager()
    let db = Firestore.firestore()
    
    func saveUserData() {
        let currentUser = UserController.shared.currentUser 
                
        let ref = db.collection(StringConstants.Users).document(currentUser.userID)
        ref.setData(["username" : currentUser.username,
//                      "favoritedRecipes" : currentUser.favoritedRecipes,
//                      "createdRecipes" : currentUser.createdRecipes
                      ])
    }
    
}

