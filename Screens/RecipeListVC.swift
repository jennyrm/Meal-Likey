//
//  RecipeListVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/13/21.
//

import UIKit

class RecipeListVC: UIViewController {
    
    var item: String!
    var recipeList = [RecipeList]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, RecipeList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
//        configureSearchController()
        configureCollectionView()
        getListOfRecipes(for: item)
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
        collectionView.register(RecipeListCell.self, forCellWithReuseIdentifier: RecipeListCell.reuseID)
    }
    
    func getListOfRecipes(for item: String) {
        NetworkManager.shared.getRecipes(for: item) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let recipeList):
                self.recipeList.append(contentsOf: recipeList.results)
                
                self.updateData(on: self.recipeList)
            case .failure(let error):
                self.presentAlertMessage(title: "Unable to connect to the network.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, recipeList in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeListCell.reuseID, for: indexPath) as! RecipeListCell
            cell.set(recipeList: recipeList)
            
            return cell
        })
    }
    
    func updateData(on recipeList: [RecipeList]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RecipeList>()
        snapshot.appendSections([.recipeList])
        snapshot.appendItems(recipeList)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

//    @objc func addButtonTapped() {
//        
//    }
    
}//End of class

extension RecipeListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipesVC = RecipesVC()
        let recipeVC = RecipeVC()
        
        guard let recipes = recipeList[indexPath.item].recipes else {
            let singleRecipeList = recipeList[indexPath.item]
            recipeVC.singleRecipeList = singleRecipeList
            navigationController?.pushViewController(recipeVC, animated: true)
            return
        }
        
        recipesVC.recipes = recipes
        navigationController?.pushViewController(recipesVC, animated: true)
    }
}

