//
//  RecipesVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipesVC: UIViewController {

    var item: String!
    var recipes = [Recipe]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
//        configureSearchController()
        configureCollectionView()
        getRecipes(for: item)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let trimmedString = item.trimmingCharacters(in: .whitespacesAndNewlines).capitalizingFirstLetter()
        title = "\(trimmedString) Recipes"
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
//        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search for a recipe"
        navigationItem.searchController = searchController
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        
//        collectionView.backgroundColor = .systemPink
        collectionView.delegate = self
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseID)
    }
    
    func getRecipes(for item: String) {
        NetworkManager.shared.getRecipes(for: item) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let recipes):
                self.recipes.append(contentsOf: recipes.results)
                self.updateData(on: self.recipes)
            case .failure(let error):
                self.presentAlertMessage(title: "Unable to connect to the network.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, recipe in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseID, for: indexPath) as! RecipeCell
            cell.set(recipe: recipe)
            
            return cell
        })
    }
    
    func updateData(on recipeList: [Recipe]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        snapshot.appendSections([.recipes])
        snapshot.appendItems(recipeList)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

//    @objc func addButtonTapped() {
//
//    }
    
}//End of class

extension RecipesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeListVC = RecipeListVC()
        let recipeVC = RecipeVC()
        
        guard let recipes = recipes[indexPath.item].recipes else {
            let recipe = recipes[indexPath.item]
            recipeVC.recipe = recipe
            navigationController?.pushViewController(recipeVC, animated: true)
            return
        }
        
        recipeListVC.recipes = recipes
        navigationController?.pushViewController(recipeListVC, animated: true)
    }
}

