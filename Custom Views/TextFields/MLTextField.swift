//
//  MLTextField.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/13/21.
//

import UIKit

class MLTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
//        placeholder = "Enter recipe name..."
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        autocapitalizationType = .words
        returnKeyType = .default
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
