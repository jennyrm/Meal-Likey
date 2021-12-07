//
//  SearchVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/11/21.
//

import UIKit

class SearchVC: UIViewController {
    
    var isItemEntered: Bool { !itemTextField.text!.isEmpty}
    
    let itemTextField = MLTextField()
    let callToActionButton = MLButton(backgroundColor: .systemPink, title: "Find Recipe")
    
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 50
    
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
        view.addSubview(itemTextField)
        
        itemTextField.delegate = self
        
        NSLayoutConstraint.activate([
            itemTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            itemTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemTextField.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: itemTextField.bottomAnchor, constant: padding),
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
        guard isItemEntered else {
            return presentAlertMessage(title: "Invalid Request", message: "Please enter a recipe name.", buttonTitle: "Ok")
        }
        
        let recipesVC = RecipesVC()
        recipesVC.item = itemTextField.text
        
        navigationController?.pushViewController(recipesVC, animated: true)
    }
    
}//End of class

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
