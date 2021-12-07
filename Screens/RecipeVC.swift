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
    var recipeImageView = MLRecipeImageView(frame: .zero)
    var recipeTitle = MLTitleLabel(textAlignment: .center, fontSize: 26, fontWeight: .bold)
    var userRatingsLabel = MLTitleLabel(textAlignment: .center, fontSize: 20, fontWeight: .light)
    var segmentedControl = MLSegmentedControl(frame: .zero)
    var tabulatedView = MLSegmentContainerView()
    
    let padding: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configureRecipeHeader()
        configureTabulatedView()
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
            print(recipe)
            recipeImageView.downloadImage(from: recipe.thumbnailUrl ?? "")
            recipeTitle.text = recipe.name
            
            let userRatingScore = (recipe.userRatings?.score ?? 0).convertToWholeNumber()
            userRatingsLabel.text = "Rating: \(userRatingScore)%"
        }
        if let recipeListItem = recipeListItem {
            print(recipeListItem)
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
            userRatingsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTabulatedView() {
        scrollView.addSubview(tabulatedView)
    
        NSLayoutConstraint.activate([
            tabulatedView.topAnchor.constraint(equalTo: userRatingsLabel.bottomAnchor, constant: padding),
            tabulatedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tabulatedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tabulatedView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding),
            tabulatedView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }

    func configureSegmentedControl() {
        tabulatedView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: tabulatedView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: tabulatedView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: tabulatedView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    func configureNutritionTab() {
        tabulatedView.backgroundColor = .systemPink
    }
    
    func configureIngredientsTab() {
        tabulatedView.backgroundColor = .systemPink
    }
    
    func configureInstructionsTab() {
        tabulatedView.backgroundColor = .systemPink
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
