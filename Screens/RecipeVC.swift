//
//  RecipeVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipeVC: UIViewController {
    
    var singleRecipeList: RecipeList?
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
}
