//
//  MLTabBarController.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/11/21.
//

import UIKit

class MLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createSearchNC(), createFavoritesNC(), createMealtimeNC()]
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search Recipe"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorite Recipes"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    private func createMealtimeNC() -> UINavigationController {
        let mealTimesVC = MealtimesVC()
        mealTimesVC.title = "Meal Times"
        mealTimesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        return UINavigationController(rootViewController: mealTimesVC)
    }

}
