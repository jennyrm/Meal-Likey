//
//  MLSegmentContainerView.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/7/21.
//

import UIKit

class MLSegmentContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
