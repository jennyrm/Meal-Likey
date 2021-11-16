//
//  UIViewController+Ext.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/15/21.
//

import UIKit

extension UIViewController {
    func presentAlertMessage(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = MLAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .coverVertical
            
            self.present(alertVC, animated: true)
        }
    }
}
