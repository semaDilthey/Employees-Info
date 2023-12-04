//
//  DepartamentsCollectionViewCell.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 28.11.2023.
//

import Foundation
import UIKit

class DepartamentsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HeaderCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeSelection()
    }

    var label: UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 15, weight: .medium)
        label.textColor = .kdLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var stringView : UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.kdPurple?.cgColor
        return view
    }()

    override var isSelected: Bool {
        didSet {
            isSelected ? selectCell() : removeSelection()
        }
    }
    
    private func setupUI() {
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func selectCell() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve) {
            self.label.textColor = .kdLightDark
            self.stringView.layer.backgroundColor = UIColor.kdPurple?.cgColor
            self.stringView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(self.stringView)
            self.stringView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.stringView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.stringView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.stringView.heightAnchor.constraint(equalToConstant: 2).isActive = true
            self.layoutIfNeeded()
        }
    }
        
        
     private func removeSelection() {
         UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve) {
             
             self.stringView.layer.backgroundColor = UIColor.clear.cgColor
             self.stringView.translatesAutoresizingMaskIntoConstraints = true
             self.stringView.removeFromSuperview()
             self.label.textColor = .kdLightGrey
             self.layoutIfNeeded()
         }
    }
}

enum DepartamentsEnum : Int {
    case all, android, iOs, design, management, qa, backoffice, frontend, hr, pr, backend, support, analitycs
}

