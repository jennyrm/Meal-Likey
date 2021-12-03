//
//  RecipesVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import UIKit

class RecipesVC: UIViewController {
    
    var recipes = [Recipe]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
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

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, recipe in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseID, for: indexPath) as! RecipeCell
            cell.set(recipe: recipe)
            
            return cell
        })
        
        updateData(on: recipes)
    }
    
    func updateData(on recipes: [Recipe]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        snapshot.appendSections([.recipes])
        snapshot.appendItems(recipes)
        
        dataSource.apply(snapshot)
    }
    
}//End of class

extension RecipesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeVC = RecipeVC()
        let recipe = recipes[indexPath.item]
        recipeVC.recipe = recipe
        
        navigationController?.pushViewController(recipeVC, animated: true)
    }
}

