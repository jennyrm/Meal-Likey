//
//  FavoriteCell.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/13/21.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"

    var recipeImageView = MLRecipeImageView(frame: .zero)
    var recipeLabel = MLTitleLabel(textAlignment: .left, fontSize: 20, fontWeight: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(recipe: Recipe) {
        recipeImageView.downloadImage(from: recipe.thumbnailUrl)
        recipeLabel.text = recipe.name
    }
    
    private func configure() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        addSubview(recipeImageView)
        addSubview(recipeLabel)
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            recipeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            recipeImageView.heightAnchor.constraint(equalToConstant: 70),
            recipeImageView.widthAnchor.constraint(equalToConstant: 70),
            
            recipeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            recipeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: padding * 3),
            recipeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 6),
            recipeLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}
