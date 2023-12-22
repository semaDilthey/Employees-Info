//
//  ErrorBanner.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 02.12.2023.
//

import UIKit

class ErrorBanner: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }

    let text : UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        return text
    }()
    
    func setupUI() {
        addSubview(text)
        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        text.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15).isActive = true
    }
    
    enum ErrorType : String {
        case noInternet = "Сan't update the data. \nCheck the internet connection"
        case badAPI = "Не могу получить данные. \nПроблемы с интернет-сервером"
    }
    
}
