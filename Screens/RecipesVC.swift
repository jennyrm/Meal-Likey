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
    var recipeCount = 0
    var recipeValue = 0
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getRecipes(for: item, from: recipeValue)
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
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseID)
    }
    
    func getRecipes(for item: String, from pagination: Int) {
        showLoadingView()
        
        NetworkManager.shared.getRecipes(for: item, from: pagination) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let recipes):
                self.recipes.append(contentsOf: recipes.results)
                self.recipeCount = recipes.count
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
    
}//End of class

extension RecipesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeListVC = RecipeListVC()
        let recipeVC = RecipeVC()
        
        guard let recipes = recipes[indexPath.item].recipes else {
            let recipe = recipes[indexPath.item]
            recipeVC.recipe = recipe
            
            let navController = UINavigationController(rootViewController: recipeVC)
            present(navController, animated: true, completion: nil)
            return
        }
        
        recipeListVC.recipes = recipes
        navigationController?.pushViewController(recipeListVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

//        print("contentHeight:", contentHeight)
//        print("contentHeight - height:", contentHeight - height)
//        print("offsetY:", offsetY)
//
        if offsetY > contentHeight - height {
            recipeValue += 40
            //if the start of the the next recipe value is greater than the count of recipescoffee, then return out
            guard recipeValue < recipeCount else { return }
            getRecipes(for: item, from: recipeValue)
        }
    }
}

