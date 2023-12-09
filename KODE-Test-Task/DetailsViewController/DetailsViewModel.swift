//
//  DetailsViewModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 24.11.2023.
//

import Foundation

protocol DetailsViewModelProtocol {
    var dataStorage : DataStorageProtocol { get set }
    
    func getDetailsConfiguration(at indexPath: IndexPath, with employees: [MainCellModelProtocol]) -> MainCellModelProtocol?
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    var dataStorage : DataStorageProtocol

    init(dataStorage: DataStorageProtocol) {
        self.dataStorage = dataStorage
    }
    
    func getDetailsConfiguration(at indexPath: IndexPath, with employees: [MainCellModelProtocol]) -> MainCellModelProtocol? {
        guard indexPath.row < employees.count else { return nil }
        return employees[indexPath.row]
      }
}
