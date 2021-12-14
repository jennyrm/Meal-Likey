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
                
        let usersRef = db.collection(StringConstants.Users).document(currentUser.userID)
        usersRef.setData(["username" : currentUser.username,
                             "favoritedRecipes" : [],
                             "createdRecipes" : []
                            ])
        
        let favoritesRef = db.collection(StringConstants.Users).document(currentUser.userID).collection(StringConstants.Favorites)
    }
    
}

