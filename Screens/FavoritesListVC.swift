//
//  FavoritesListVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/12/21.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    var favorites = [Recipe]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        UserController.shared.getUserData()
        fetchFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorite Recipes"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func fetchFavorites() {
        //jennyrm - FIX
        let favorites = UserController.shared.currentUser.favoritedRecipes
        self.favorites = favorites
        tableView.reloadData()
    }

}//End of class

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        
        let recipe = favorites[indexPath.row]
        cell.set(recipe: recipe)
        
        return cell
    }
}

