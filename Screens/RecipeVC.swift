//
//  RecipeVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipeVC: UIViewController {
    
    var recipe: Recipe?

    var scrollView: UIScrollView!
    var headerView = UIView()
    var tabulatedView = UIView()
    var itemViews = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureFavoriteButton()
        configureScrollView()
        configureUIElements()
        addSubviewsAndLayoutUI()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem = doneButton
    }
    
    func configureFavoriteButton() {
        guard let recipe = recipe else { return }
        
//        if UserController.sharedInstance.isAlreadyFavorited(recipe) {
//            recipe.isFavorited = true
//        }
//        
        let favoriteButtonIcon = recipe.isFavorited == true ? SFSymbols.heartFilled : SFSymbols.heart
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: favoriteButtonIcon), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
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
    
    func configureUIElements() {
        guard let recipe = recipe else { return }
        
        self.add(childVC: MLRecipeHeaderVC(recipe: recipe), to: self.headerView)
        self.add(childVC: MLTabulatedInfoVC(recipe: recipe), to: self.tabulatedView)
    }
    
    func addSubviewsAndLayoutUI() {
        let padding: CGFloat = 12
        
        itemViews = [headerView, tabulatedView]
        
        for itemView in itemViews {
            scrollView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 400),
            
            tabulatedView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            tabulatedView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tabulatedView.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func favoriteButtonTapped() {
        if recipe?.isFavorited == false {
            recipe?.isFavorited = true
            UserController.shared.addToFavorites(recipe!)
            
            configureFavoriteButton()
            DatabaseManager.shared.saveUserData()
        } else {
            UserController.shared.removeFromFavorites(recipe!)
            recipe?.isFavorited = false
            
            configureFavoriteButton()
        }
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
