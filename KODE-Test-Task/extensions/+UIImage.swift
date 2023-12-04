//
//  +UIImage.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 27.11.2023.
//
import UIKit

extension UIImage {
  
  func imageWithColor(color: UIColor) -> UIImage {
      UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
      let context = UIGraphicsGetCurrentContext()

      color.setFill()

      context!.translateBy(x: 0, y: self.size.height)
      context!.scaleBy(x: 1.0, y: -1.0)

      context!.setBlendMode(CGBlendMode.colorBurn)
      let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
      context!.draw(self.cgImage!, in: rect)

      context!.setBlendMode(CGBlendMode.sourceIn)
      context!.addRect(rect)
      context!.drawPath(using: CGPathDrawingMode.fill)

      let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return coloredImage!
  }
  
}
