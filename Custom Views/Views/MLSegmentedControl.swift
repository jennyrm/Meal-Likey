//
//  MLSegmentedControl.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/6/21.
//

import UIKit

class MLSegmentedControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        removeAllSegments()
        insertSegment(withTitle: "Nutrition", at: 0, animated: true)
        insertSegment(withTitle: "Ingredients", at: 1, animated: true)
        insertSegment(withTitle: "Instructions", at: 2, animated: true)
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
