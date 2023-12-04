//
//  +UIView.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 29.11.2023.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(radius: CGFloat, color: UIColor = .black, opacity: Float = 0.1, offset: CGSize = .zero) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}
