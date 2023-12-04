//
//  CorrectSearchView.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 30.11.2023.
//

import UIKit

class CorrectSearchView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private let image : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loopa")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .bold)
        label.textColor = .kdBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We didn't find anyone"
        return label
    }()
    
    private let lowerLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .medium)
        label.textColor = .kdLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Let's try tweaking the query a bit"
        return label
    }()

    private func setupUI() {
        backgroundColor = .clear
        let labelsStack = UIStackView(arrangedSubviews: [mainLabel, lowerLabel])
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.axis = .vertical
        labelsStack.alignment = .center
        labelsStack.distribution = .fillEqually
        labelsStack.spacing = 10
        
        let stackWithImage = UIStackView(arrangedSubviews: [image, labelsStack])
        stackWithImage.translatesAutoresizingMaskIntoConstraints = false
        stackWithImage.axis = .vertical
        stackWithImage.alignment = .center
        stackWithImage.distribution = .equalSpacing
        stackWithImage.spacing = 8
        
        addSubview(stackWithImage)
        
        stackWithImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackWithImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
