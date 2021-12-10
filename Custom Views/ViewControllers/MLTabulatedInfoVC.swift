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
        configureSegmentContainerView()
        configureSegmentedControl()
        configureNutritionTab()
        configureIngredientsTab()
        configureInstructionsTab()
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
        guard let nutrition = recipe.nutrition else { return }
        
        var nutritionArray = [String]()
        
        let calories = nutrition.calories != nil ? "Calories: \(nutrition.calories!)" : "Calories: ——"
        nutritionArray.append(calories)
        
        let fat = nutrition.fat != nil ? "Fat: \(nutrition.fat!)" : "Fat: ——"
        nutritionArray.append(fat)
        
        let carbohydrates = nutrition.carbohydrates != nil ? "Carbohydrates: \(nutrition.carbohydrates!)" : "Carbohydrates: ——"
        nutritionArray.append(carbohydrates)
        
        let fiber = nutrition.fiber != nil ? "Fiber: \(nutrition.fiber!)" : "Fiber: ——"
        nutritionArray.append(fiber)
       
        let sugar = nutrition.sugar != nil ? "Sugar: \(nutrition.sugar!)" : "Sugar: ——"
        nutritionArray.append(sugar)
        
        let protein = nutrition.protein != nil ? "Protein: \(nutrition.protein!)" : "Protein: ——"
        nutritionArray.append(protein)

        nutritionArray.append("*Estimated values based on one serving size.")
        
        //        let nutritionString = "\(numServings)\n\n\(calories)\n\n\(fat)\n\n\(carbs)\n\n\(fiber)\n\n\(sugar)\n\n\(protein)"
        let nutritionString = nutritionArray.reduce("") { $0 + "\n" + $1 + "\n"}
        
        segmentContainerView.set(itemInfoType: .nutrition, with: nutritionString)
    }
    
    private func configureIngredientsTab() {
        guard let sections = recipe.sections else { return }
        
        let recipeComponents = sections.map { $0.components }
        let ingredientsArray = recipeComponents.reduce([]) { $0 + $1 }
        let ingredientsString = ingredientsArray.map { $0.rawText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
        segmentContainerView.set(itemInfoType: .ingredients, with: ingredientsString)
    }
    
    private func configureInstructionsTab() {
        guard let instructions = recipe.instructions else { return }
        
        let instructionsString = instructions.map { $0.displayText }.reduce("") { $0 + "\n" + $1 + "\n" }
        
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
