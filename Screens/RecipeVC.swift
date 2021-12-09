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
    
    let padding: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        print(recipe!)
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
    
    @objc func favoriteButtonTapped() {
        
    }
    
    @objc func doneButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
