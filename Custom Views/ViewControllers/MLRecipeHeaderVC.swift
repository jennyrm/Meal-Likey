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
    let numServingsLabel = MLSecondaryBodyLabel(fontSize: 14, fontWeight: .light)
    let userRatingsLabel = MLSecondaryBodyLabel(fontSize: 18, fontWeight: .semibold)
    let placeholderLabel = MLSecondaryBodyLabel(fontSize: 14, fontWeight: .light)
    
    init(recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        addSubviews()
        layoutUI()
    }
    
    private func configureUIElements() {
        guard let userRatings = recipe.userRatings else { return }
        
        recipeImageView.downloadImage(from: recipe.thumbnailUrl!)
        
        recipeTitle.text = recipe.name
        
        let numServings = recipe.numServings != 0 ? "Servings\n \(recipe.numServings!)" : "Servings: —"
        numServingsLabel.text = numServings
        
        let userRatingScore = recipe.userRatings?.score != 0 ? "  Rating: \(userRatings.score!.convertToWholeNumber())%  " : "   Rating: ——   "
        userRatingsLabel.text = userRatingScore
        
        let userLikes = userRatings.score == 0 && recipe.userRatings?.countPositive == 0 ? "Likes: —" : "Likes: \(userRatings.countPositive!)"
        let userDislikes = userRatings.score == 0 && recipe.userRatings?.countNegative == 0 ? "Dislikes: —" : "Dislikes: \(userRatings.countNegative!)"
        placeholderLabel.text = "\(userLikes)\n\(userDislikes)"
    }
    
    private func addSubviews() {
        view.addSubview(recipeImageView)
        view.addSubview(recipeTitle)
        view.addSubview(numServingsLabel)
        view.addSubview(userRatingsLabel)
        view.addSubview(placeholderLabel)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 8
        let itemHeight: CGFloat = 60
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeImageView.heightAnchor.constraint(equalToConstant: 280),
            
            recipeTitle.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            recipeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTitle.heightAnchor.constraint(equalToConstant: 70),
            
            numServingsLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            numServingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            numServingsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            numServingsLabel.heightAnchor.constraint(equalToConstant: itemHeight),
            
            userRatingsLabel.centerXAnchor.constraint(equalTo: recipeTitle.centerXAnchor),
            userRatingsLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            userRatingsLabel.leadingAnchor.constraint(equalTo: numServingsLabel.trailingAnchor, constant: padding / 2),
            userRatingsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            userRatingsLabel.heightAnchor.constraint(equalToConstant: itemHeight),
            
            placeholderLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            placeholderLabel.leadingAnchor.constraint(equalTo: userRatingsLabel.trailingAnchor, constant: padding / 2),
            placeholderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            placeholderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            placeholderLabel.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }

}
