//
//  +UIFont.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 22.11.2023.
//

import Foundation
import UIKit

extension UIFont {
    
    enum InterFontWeight: Int {
        case extraBold = 800
        case bold = 700
        case medium = 600
        case regular = 500
        case thin = 400
        case light = 300
        case extraLight = 200
        
        var nameFont: String {
            switch self {
            case .bold:
                return "Inter-Bold"
            case .extraBold:
                return "Inter-ExtraBold"
            case .medium:
                return "Inter-Medium"
            case .regular:
                return "Inter-Regular"
            case .thin:
                return "Inter-Thin"
            case .light:
                return"Inter-Light"
            case .extraLight:
                return "Inter-ExtraLight"
            }
        }
    }
    
    static func interFont(size fontSize: CGFloat, weight fontWeight: InterFontWeight) -> UIFont? {
        UIFont(name: fontWeight.nameFont, size: fontSize)
    }
}
