//
//  MLBodyLabel.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 11/13/21.
//

import UIKit

class MLBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        
        configure()
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .secondaryLabel
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
