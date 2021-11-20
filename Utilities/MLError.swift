//
//  MLError.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/19/21.
//

import Foundation

enum MLError: String, Error  {
    case invalidRecipe = "This recipe name created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error adding this to favorites."
    case alreadyInFavorites = "You've already favorited this recipe."
}
