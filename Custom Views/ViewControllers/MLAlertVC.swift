//
//  MLAlertVC.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/13/21.
//

import UIKit

class MLAlertVC: UIViewController {
    
    let containerView = MLAlertContainer()
    let titleLabel = MLTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = MLBodyLabel(textAlignment: .center)
    let actionButton = MLButton(backgroundColor: .systemPink, title: "Ok")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
