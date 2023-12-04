//
//  +UIViewController.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 23.11.2023.
//

import Foundation

import SwiftUI

extension UIViewController {
    private struct Preview : UIViewControllerRepresentable {
        let viewController : UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
    func showPreview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
    
}
