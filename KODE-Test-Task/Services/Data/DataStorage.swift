//
//  DataSource.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 21.11.2023.
//

import Foundation

protocol DataStorageProtocol {
    var employees : [MainCellModelProtocol] {get set}
}


struct DataStorage: DataStorageProtocol {
    
    var employees : [MainCellModelProtocol] = []
    
    let dictinary = ConstantsManager.shared.departaments
    
    mutating func addEmployee(employee: MainCellModelProtocol) {
        employees.append(employee)
    }
    
    mutating func removeEmployee(at index : Int) {
        employees.remove(at: index)
    }
}


