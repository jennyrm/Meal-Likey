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
        
        nutrition.calories != nil ? nutritionArray.append("Calories: \(nutrition.calories!)") : nutritionArray.append("Calories: ——")
        nutrition.fat != nil ? nutritionArray.append("Fat: \(nutrition.fat!)") : nutritionArray.append("Fat: ——")
        nutrition.carbohydrates != nil ? nutritionArray.append("Carbohydrates: \(nutrition.carbohydrates!)") : nutritionArray.append("Carbohydrates: ——")
        nutrition.fiber != nil ? nutritionArray.append("Fiber: \(nutrition.fiber!)") : nutritionArray.append("Fiber: ——")
        nutrition.sugar != nil ? nutritionArray.append("Sugar: \(nutrition.sugar!)") : nutritionArray.append("Sugar: ——")
        nutrition.protein != nil ? nutritionArray.append("Protein: \(nutrition.protein!)") : nutritionArray.append("Protein: ——")
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
