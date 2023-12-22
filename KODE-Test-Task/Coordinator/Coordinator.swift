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
    func showwMainVC(navController: UINavigationController?)
    func showErrorController(navController: UINavigationController?)
    func showDetailsController(navController: UINavigationController?, dataStorage: DataStorageProtocol)
}

class Coordinator: CoordinatorProtocol {
    
    func start(window: UIWindow)  {
        let viewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: DataStorage())
        let vc = MainViewController(viewModel: viewModel)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        }
    
    func showwMainVC(navController: UINavigationController?) {
        guard let navController else { return }
        let viewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: DataStorage())
        let vc = MainViewController(viewModel: viewModel)
        setViewController(controller: navController, with: [vc])
    }
    
    func showErrorController(navController: UINavigationController?) {
        guard let navController else { return }
        let vc = ErrorViewController()
        setViewController(controller: navController, with: [vc])
    }
    
    func showDetailsController(navController: UINavigationController?, dataStorage: DataStorageProtocol) {
        guard let navController else { return }
        let viewModel = DetailsViewModel(dataStorage: dataStorage)
        let vc = DetailsViewController(viewModel: viewModel)
        setViewController(controller: navController, with: [vc])
    }

    
    private func setViewController(controller: UINavigationController, with viewControllers: [UIViewController], animated: Bool = true) {
        var vcArray = controller.viewControllers
        vcArray.removeAll()
        vcArray.append(contentsOf: viewControllers)

        controller.setViewControllers(vcArray, animated: animated)
    }

}
