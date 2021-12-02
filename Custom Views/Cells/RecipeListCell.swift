//
//  RecipeListCell.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/1/21.
//

import UIKit

class RecipeListCell: UICollectionViewCell {
    static let reuseID = "RecipeListCell"
    
    let recipesLabel = MLTitleLabel(textAlignment: .center, fontSize: 16)
    let recipesImageView = MLRecipeImageView(frame: .zero)
}
