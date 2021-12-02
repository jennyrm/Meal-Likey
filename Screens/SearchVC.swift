//
//  SearchVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/11/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let foodTextField = MLTextField()
    let callToActionButton = MLButton(backgroundColor: .systemTeal, title: "Find Recipe")
    
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 50
    
    var isFoodNameEntered: Bool { !foodTextField.text!.isEmpty}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureTextField() {
        view.addSubview(foodTextField)
        
        foodTextField.delegate = self
        
        NSLayoutConstraint.activate([
            foodTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            foodTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            foodTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            foodTextField.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: foodTextField.bottomAnchor, constant: padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6 * padding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6 * padding),
            callToActionButton.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
        
        callToActionButton.addTarget(self, action: #selector(pushRecipeListVC), for: .touchUpInside)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushRecipeListVC() {
        guard isFoodNameEntered else {
            return presentAlertMessage(title: "Invalid Request", message: "Please enter a recipe name.", buttonTitle: "Ok")
        }
        
        let recipeListVC = RecipeListVC()
        recipeListVC.title = "Recipes with \(foodTextField.text!)"
        recipeListVC.foodName = foodTextField.text
        
        navigationController?.pushViewController(recipeListVC, animated: true)
    }
    
}//End of class

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
