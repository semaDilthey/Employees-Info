//
//  ErrorViewController.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 24.11.2023.
//

import Foundation
import UIKit

class ErrorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .kdWhite
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        navigationItem.hidesBackButton = true
    }
    
    private let image : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ufo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .bold)
        label.textColor = .kdBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some genius just broke everything again"
        return label
    }()
    
    private let middleLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .medium)
        label.textColor = .kdLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ttying to fix it in record time."
        return label
    }()
    
    lazy var againButton : UIButton = {
        let button = UIButton()
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(.kdPurple, for: .normal)
        button.titleLabel?.font = .interFont(size: 14, weight: .extraBold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapButton() {
        let coordinator = Coordinator()
        coordinator.showwMainVC(controller: navigationController!)
    }
}


private extension ErrorViewController {
    func setupUI() {
        let labelsStack = UIStackView(arrangedSubviews: [mainLabel, middleLabel, againButton])
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
        
        view.addSubview(stackWithImage)
        
        stackWithImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackWithImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
