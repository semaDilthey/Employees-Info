//
//  ErrorViewModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 09.12.2023.
//

import Foundation
import UIKit

protocol ErrorViewModelProtocol {
    func presentMainController(controller: UINavigationController)
}

class ErrorViewModel : ErrorViewModelProtocol {
    func presentMainController(controller: UINavigationController) {
        let coordinator = Coordinator()
        coordinator.showwMainVC(controller: controller)
    }
}
