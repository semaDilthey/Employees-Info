//
//  SeparatorView.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 02.12.2023.
//

import UIKit

class SeparatorView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private let leftLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kdLightGrey
        return view
    }()
    
    private let yearLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .medium)
        label.textColor = .kdLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022"
        return label
    }()
    
    private let rightLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kdLightGrey
        return view
    }()

    private func setupUI() {
        backgroundColor = .clear
        let stack = UIStackView(arrangedSubviews: [leftLine, yearLabel, rightLine])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        leftLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        rightLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(stack)
        
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
