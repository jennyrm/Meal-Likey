//
//  MLEmptyStateView.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/19/21.
//

import UIKit

class MLEmptyStateView: UIView {

    let messageLabel = MLTitleLabel(textAlignment: .center, fontSize: 28, fontWeight: .bold)
    let emptyImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        //why .zero?
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(emptyImageView)
        
        messageLabel.textColor = .secondaryLabel
        
        emptyImageView.image = UIImage(named: "")
        
        NSLayoutConstraint.activate([
        ])
    }

}
