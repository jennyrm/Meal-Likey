//
//  UIViewController+Ext.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/15/21.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentAlertMessage(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = MLAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = MLEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
