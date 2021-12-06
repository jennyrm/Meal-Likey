//
//  RecipeListVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipeListVC: UIViewController {

    var recipeList = [RecipeList]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, RecipeList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "More Recipes"
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(RecipeListCell.self, forCellWithReuseIdentifier: RecipeListCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, recipeList in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeListCell.reuseID, for: indexPath) as! RecipeListCell
            cell.set(recipeList: recipeList)
            
            return cell
        })
        
        updateData(on: recipeList)
    }
    
    func updateData(on recipes: [RecipeList]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RecipeList>()
        snapshot.appendSections([.recipeList])
        snapshot.appendItems(recipes)
        
        dataSource.apply(snapshot)
    }
    
}//End of class

extension RecipeListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeVC = RecipeVC()
        let recipeListItem = recipeList[indexPath.item]
        recipeVC.recipeListItem = recipeListItem
        
        let navController = UINavigationController(rootViewController: recipeVC)
        present(navController, animated: true, completion: nil)
    }
}
