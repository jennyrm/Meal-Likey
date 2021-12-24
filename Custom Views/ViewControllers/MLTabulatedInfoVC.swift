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
    
    init(recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegmentContainerView()
        configureSegmentedControl()
        configureNutritionTab()
        configureIngredientsTab()
        configureInstructionsTab()
    }
    
    private func configureSegmentContainerView() {
        view.addSubview(segmentContainerView)
        
        NSLayoutConstraint.activate([
            segmentContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            segmentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        let nutrition = recipe.nutrition
        
        var nutritionArr = [String]()
        
        let calories = nutrition.calories != nil ? "Calories: \(nutrition.calories!)" : "Calories: ——"
        nutritionArr.append(calories)
        
        let fat = nutrition.fat != nil ? "Fat: \(nutrition.fat!)" : "Fat: ——"
        nutritionArr.append(fat)
        
        let carbohydrates = nutrition.carbohydrates != nil ? "Carbohydrates: \(nutrition.carbohydrates!)" : "Carbohydrates: ——"
        nutritionArr.append(carbohydrates)
        
        let fiber = nutrition.fiber != nil ? "Fiber: \(nutrition.fiber!)" : "Fiber: ——"
        nutritionArr.append(fiber)
       
        let sugar = nutrition.sugar != nil ? "Sugar: \(nutrition.sugar!)" : "Sugar: ——"
        nutritionArr.append(sugar)
        
        let protein = nutrition.protein != nil ? "Protein: \(nutrition.protein!)" : "Protein: ——"
        nutritionArr.append(protein)

        nutritionArr.append("*Estimated values based on one serving size.")
        
        //        let nutritionString = "\(numServings)\n\n\(calories)\n\n\(fat)\n\n\(carbs)\n\n\(fiber)\n\n\(sugar)\n\n\(protein)"
        let nutritionString = nutritionArr.reduce("") { $0 + "\n" + $1 + "\n"}
        
        segmentContainerView.set(itemInfoType: .nutrition, with: nutritionString)
    }
    
    private func configureIngredientsTab() {
        let recipeComponents = recipe.sections.map { $0.components }
        let ingredientsArr = recipeComponents.reduce([]) { $0 + $1 }
        let ingredientsString = ingredientsArr.map { $0.rawText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
        segmentContainerView.set(itemInfoType: .ingredients, with: ingredientsString)
    }
    
    private func configureInstructionsTab() {
        let instructionsString = recipe.instructions.map { $0.displayText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
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
