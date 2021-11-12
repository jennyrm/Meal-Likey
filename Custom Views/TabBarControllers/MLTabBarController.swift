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

        viewControllers = [SearchVC(), FavoritesVC(), MealTimeVC()]
    }
    
    

}
