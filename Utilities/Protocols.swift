//
//  Protocols.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/29/21.
//

import Foundation

protocol isAlreadyFavorited: AnyObject {
    func toggleFavoriteButton(on recipe: Recipe)
}
