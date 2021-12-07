//
//  RecipeListCell.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipeListCell: UICollectionViewCell {
    
    static let reuseID = "RecipeListCell"
    
    let recipeListLabel = MLBodyLabel(textAlignment: .left)
    let recipeListImageView = MLRecipeImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(recipeList: RecipeList) {
        recipeListLabel.text = recipeList.name
        //jennyrm - 
        recipeListImageView.downloadImage(from: recipeList.thumbnailUrl ?? "")
    }
    
    private func configure() {
        addSubview(recipeListLabel)
        addSubview(recipeListImageView)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            recipeListLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            recipeListLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            recipeListLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            recipeListLabel.heightAnchor.constraint(equalToConstant: 80),
            
            recipeListImageView.topAnchor.constraint(equalTo: recipeListLabel.bottomAnchor),
            recipeListImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            recipeListImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            recipeListImageView.heightAnchor.constraint(equalToConstant: 100),
            recipeListImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
