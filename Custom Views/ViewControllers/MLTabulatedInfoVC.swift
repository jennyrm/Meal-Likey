//
//  MLTabulatedInfoVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/9/21.
//

import UIKit

class MLTabulatedInfoVC: UIViewController {
    
    var recipe: Recipe!
    
    let segmentContainerView = MLSegmentContainerView()
    let segmentedControl = MLSegmentedControl(frame: .zero)
    
    let padding: CGFloat = 12
    
    init(recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func configureSegmentContainerView() {
        view.addSubview(segmentContainerView)
        
        NSLayoutConstraint.activate([
            segmentContainerView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            segmentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            segmentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            segmentContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            segmentContainerView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    private func configureSegmentedControl() {
        segmentContainerView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentContainerView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentContainerView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureNutritionTab() {
        if let recipe = recipe?.nutrition {
            getNutrition(for: recipe)
        }
    }
    
    private func getNutrition(for recipeType: Nutrition) {
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
        
        nutritionArray.append("*Estimated values based on one serving size.")
        
//        let nutritionString = "\(numServings)\n\n\(calories)\n\n\(fat)\n\n\(carbs)\n\n\(fiber)\n\n\(sugar)\n\n\(protein)"
        let nutritionString = nutritionArray.reduce("") { $0 + "\n" + $1 + "\n"}
        
        segmentContainerView.set(itemInfoType: .nutrition, with: nutritionString)
    }
    
    private func configureIngredientsTab() {
        if let recipe = recipe?.sections {
            getIngredients(for: recipe)
        }
    }
    
    private func getIngredients(for recipeType: [RecipeComponent]) {
        let recipeComponents = recipeType.map { $0.components }
        let ingredientsArray = recipeComponents.reduce([]) { $0 + $1 }
        let ingredientsString = ingredientsArray.map { $0.rawText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
        segmentContainerView.set(itemInfoType: .ingredients, with: ingredientsString)
    }
    
    func configureInstructionsTab() {
        if let recipe = recipe?.instructions {
            getInstructions(for: recipe)
        }
    }
    
    private func getInstructions(for recipeType: [Instruction]) {
        let instructionsString = recipeType.map { $0.displayText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
        segmentContainerView.set(itemInfoType: .instructions, with: instructionsString)
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
