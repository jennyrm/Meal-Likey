//
//  MLSecondaryBodyLabel.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/10/21.
//

import UIKit

class MLSecondaryBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        
        configure()
    }
    
    private func configure() {
        backgroundColor = .systemGray6
//        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .secondaryLabel
        textAlignment = .center
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.masksToBounds = true
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        
        translatesAutoresizingMaskIntoConstraints = false
    }


}
