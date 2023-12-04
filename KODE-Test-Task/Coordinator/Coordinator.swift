//
//  Coordinator.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 24.11.2023.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start(window: UIWindow)
    func showwMainVC(controller: UINavigationController)
    func showErrorController(controller: UINavigationController)
    func showDetailsController(controller: UINavigationController)
    
}
class Coordinator: CoordinatorProtocol {
    
    func start(window: UIWindow)  {
        let viewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: DataStorage(), filterViewModel: nil)
        let vc = MainViewController(viewModel: viewModel)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        }
    
    func showwMainVC(controller: UINavigationController) {
        let viewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: DataStorage(), filterViewModel: nil)
        let vc = MainViewController(viewModel: viewModel)
        setViewController(controller: controller, with: [vc])
    }
    
    func showErrorController(controller: UINavigationController) {
        let vc = ErrorViewController()
        setViewController(controller: controller, with: [vc])
    }
    
    func showDetailsController(controller: UINavigationController) {
        let vc = DetailsViewController(viewModel: DetailsViewModel(dataStorage: DataStorage()))
        setViewController(controller: controller, with: [vc])
    }
    
    private func setViewController(controller: UINavigationController, with viewControllers: [UIViewController], animated: Bool = true) {
        var vcArray = controller.viewControllers
        vcArray.removeAll()
        vcArray.append(contentsOf: viewControllers)

        controller.setViewControllers(vcArray, animated: animated)
    }

}
