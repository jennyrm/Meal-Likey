//
//  SearchVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/11/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let recipeTextField = MLTextField()
    let callToActionButton = MLButton(backgroundColor: .systemTeal, title: "Find")
    
    var isRecipeEntered: Bool { !recipeTextField.text!.isEmpty}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addSubviewsAndLayoutUI()
        createDismissKeyboardTapGesture()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func addSubviewsAndLayoutUI() {
        view.addSubview(recipeTextField)
        view.addSubview(callToActionButton)
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 50
        
        NSLayoutConstraint.activate([
            recipeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            recipeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTextField.heightAnchor.constraint(equalToConstant: itemHeight),
            
            callToActionButton.topAnchor.constraint(equalTo: recipeTextField.bottomAnchor, constant: padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6 * padding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6 * padding),
            callToActionButton.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
        
        callToActionButton.addTarget(self, action: #selector(pushRecipeListVC), for: .touchUpInside)
    }
    
    @objc func pushRecipeListVC() {
        //add alertController
        guard isRecipeEntered else { return }
        
        let recipeListVC = RecipeListVC()
        recipeListVC.title = "\(recipeTextField.text!) Recipes"
        recipeListVC.recipeName = recipeTextField.text
        
        navigationController?.pushViewController(recipeListVC, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
}

//MARK: - Extensions
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
