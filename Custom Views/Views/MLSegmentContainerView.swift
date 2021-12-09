//
//  MLSegmentContainerView.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/7/21.
//

import UIKit

enum ItemInfoType {
    case nutrition, ingredients, instructions
}

class MLSegmentContainerView: UIView {
    
    var scrollView: UIScrollView!
    let contentLabel = MLBodyLabel(textAlignment: .left)
    
    let padding: CGFloat = 12

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureScrollView()
        configureContentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.systemGray6.cgColor
        layer.cornerRadius = 10
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView()
//        scrollView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1, constant: 0.0))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureContentLabel() {
//        contentLabel.backgroundColor = .systemGray6
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            //segmented control is 30pts tall and at the top of the view
            contentLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 42),
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, with text: String) {
        switch itemInfoType {
        case .nutrition:
            contentLabel.text = text
        case .ingredients:
            contentLabel.text = text
        case .instructions:
            contentLabel.text = text
        }
    }

}
