//
//  RecipeCell.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    static let reuseID = "RecipeCell"
    
    let recipeLabel = MLBodyLabel(textAlignment: .left)
    let recipeImageView = MLRecipeImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(recipe: Recipe) {
        recipeLabel.text = recipe.name
        recipeImageView.downloadImage(from: recipe.thumbnailUrl ?? "")
    }
    
    private func configure() {
        addSubview(recipeLabel)
        addSubview(recipeImageView)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            recipeLabel.heightAnchor.constraint(equalToConstant: 80),
            
            recipeImageView.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            recipeImageView.heightAnchor.constraint(equalToConstant: 100),
            recipeImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
