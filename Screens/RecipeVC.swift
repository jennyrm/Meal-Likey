//
//  RecipeVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipeVC: UIViewController {
    
    var recipe: Recipe?
    var recipeListItem: RecipeList?
    
    var scrollView: UIScrollView!
    let recipeImageView = MLRecipeImageView(frame: .zero)
    let recipeTitle = MLTitleLabel(textAlignment: .center, fontSize: 26, fontWeight: .bold)
    let userRatingsLabel = MLTitleLabel(textAlignment: .center, fontSize: 20, fontWeight: .light)
    let segmentedControl = MLSegmentedControl(frame: .zero)
    let segmentContainerView = MLSegmentContainerView()
    
    let padding: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configureRecipeHeader()
        configureSegmentContainerView()
        configureSegmentedControl()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: StringConstants.heart), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.leftBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureRecipeHeader() {
        //jennyrm - FIX
        if let recipe = recipe {
            recipeImageView.downloadImage(from: recipe.thumbnailUrl ?? "")
            recipeTitle.text = recipe.name
            
            let userRatingScore = (recipe.userRatings?.score ?? 0).convertToWholeNumber()
            let userLikes = recipe.userRatings?.countPositive ?? 0
            let userDislikes = recipe.userRatings?.countNegative ?? 0
            userRatingsLabel.text = "Rating: \(userRatingScore)%\n Likes: \(userLikes)\nDislikes: \(userDislikes)"
        }
        
        if let recipeListItem = recipeListItem {
            recipeImageView.downloadImage(from: recipeListItem.thumbnailUrl ?? "")
            recipeTitle.text = recipeListItem.name
            
            let userRatingScore = (recipeListItem.userRatings?.score ?? 0).convertToWholeNumber()
            userRatingsLabel.text = "Rating: \(userRatingScore)%"
        }
        
        scrollView.addSubview(recipeImageView)
        scrollView.addSubview(recipeTitle)
        scrollView.addSubview(userRatingsLabel)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeImageView.heightAnchor.constraint(equalToConstant: 280),
            
            recipeTitle.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            recipeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTitle.heightAnchor.constraint(equalToConstant: 70),
            
            userRatingsLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor),
            userRatingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userRatingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userRatingsLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureSegmentContainerView() {
        scrollView.addSubview(segmentContainerView)
        
        NSLayoutConstraint.activate([
            segmentContainerView.topAnchor.constraint(equalTo: userRatingsLabel.bottomAnchor, constant: padding),
            segmentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            segmentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            segmentContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding),
            segmentContainerView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func configureSegmentedControl() {
        segmentContainerView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentContainerView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentContainerView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    func getNutrition(for recipeType: Nutrition) {
        var nutritionArray = [String]()
        
        if let calories = recipeType.calories {
            nutritionArray.append("Calories: \(calories)")
        } else {
            nutritionArray.append("Calories: —")
        }
        
        if let fat = recipeType.fat {
            nutritionArray.append("Fat: \(fat)")
        } else {
            nutritionArray.append("Fat: —")
        }
        
        if let carbohydrates = recipeType.carbohydrates {
            nutritionArray.append("Carbohydrates: \(carbohydrates)")
        } else {
            nutritionArray.append("Carbohydrates: —")
        }
        
        if let fiber = recipeType.fiber {
            nutritionArray.append("Fiber: \(fiber)")
        } else {
            nutritionArray.append("Fiber: —")
        }
        
        if let sugar = recipeType.sugar {
            nutritionArray.append("Sugar: \(sugar)")
        } else {
            nutritionArray.append("Sugar: —")
        }
        
        if let protein = recipeType.protein {
            nutritionArray.append("Protein: \(protein)")
        } else {
            nutritionArray.append("Protein: —")
        }
        
//        let nutritionString = "\(numServings)\n\n\(calories)\n\n\(fat)\n\n\(carbs)\n\n\(fiber)\n\n\(sugar)\n\n\(protein)"
        let nutritionString = nutritionArray.reduce("") { $0 + "\n" + $1 + "\n"}
        
        segmentContainerView.set(itemInfoType: .nutrition, with: nutritionString)
    }
    
    func configureNutritionTab() {
        if let recipe = recipe?.nutrition {
            getNutrition(for: recipe)
        }
        
        if let recipeListItem = recipeListItem?.nutrition {
            getNutrition(for: recipeListItem)
        }
    }
    
    func configureIngredientsTab() {
        if let recipe = recipe?.sections {
            getIngredients(for: recipe)
        }
        
        if let recipeListItem = recipeListItem?.sections {
            getIngredients(for: recipeListItem)
        }
    }
    
    func getIngredients(for recipeType: [RecipeComponent]) {
        let recipeComponents = recipeType.map { $0.components }
        let ingredientsArray = recipeComponents.reduce([]) { $0 + $1 }
        let ingredientsString = ingredientsArray.map { $0.rawText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
        segmentContainerView.set(itemInfoType: .ingredients, with: ingredientsString)
    }
    
    func configureInstructionsTab() {
        if let recipe = recipe?.instructions {
            getInstructions(for: recipe)
        }
        
        if let recipeListItem = recipeListItem?.instructions {
            getInstructions(for: recipeListItem)
        }
    }
    
    func getInstructions(for recipeType: [Instruction]) {
        let instructionsString = recipeType.map { $0.displayText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
        segmentContainerView.set(itemInfoType: .instructions, with: instructionsString)
    }
    
    @objc func favoriteButtonTapped() {
        
    }
    
    @objc func doneButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func segmentedValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            configureNutritionTab()
        case 1:
            configureIngredientsTab()
        case 2:
            configureInstructionsTab()
        default:
            return
        }
    }
    
}
