//
//  MLRecipeHeaderVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/9/21.
//

import UIKit

class MLRecipeHeaderVC: UIViewController {
    
    var recipe: Recipe!
    
    let recipeImageView = MLRecipeImageView(frame: .zero)
    let recipeTitle = MLTitleLabel(textAlignment: .center, fontSize: 26, fontWeight: .bold)
    let numServingsLabel = MLBodyLabel(textAlignment: .center)
    let userRatingsLabel = MLTitleLabel(textAlignment: .center, fontSize: 20, fontWeight: .light)
    let placeholderLabel = MLBodyLabel(textAlignment: .center)
    
    let padding: CGFloat = 12
    
    init(recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    private func configureRecipeHeader() {
        //jennyrm - FIX
        if let recipe = recipe {
            recipeImageView.downloadImage(from: recipe.thumbnailUrl ?? "")
            recipeTitle.text = recipe.name
            
            numServingsLabel.text = "Servings: \(recipe.numServings ?? 0)"
            
            let userRatingScore = (recipe.userRatings?.score ?? 0).convertToWholeNumber()
            let userLikes = recipe.userRatings?.countPositive ?? 0
            let userDislikes = recipe.userRatings?.countNegative ?? 0
            userRatingsLabel.text = "Rating: \(userRatingScore)%\n Likes: \(userLikes)\nDislikes: \(userDislikes)"
        }
        
        view.addSubview(recipeImageView)
        view.addSubview(recipeTitle)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeImageView.heightAnchor.constraint(equalToConstant: 280),
            
            recipeTitle.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            recipeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTitle.heightAnchor.constraint(equalToConstant: 70),
            
            numServingsLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor),
            numServingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            numServingsLabel.heightAnchor.constraint(equalToConstant: 80),
            numServingsLabel.widthAnchor.constraint(equalToConstant: 150),
            
//            userRatingsLabel.centerXAnchor.constraint(equalTo: recipeTitle.bottomAnchor),
            userRatingsLabel.leadingAnchor.constraint(equalTo: numServingsLabel.leadingAnchor, constant: padding),
            userRatingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userRatingsLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
