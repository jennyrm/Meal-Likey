//
//  MLPickerView.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/6/21.
//

import UIKit

class MLPickerView: UIPickerView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
