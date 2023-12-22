//
//  CellModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 21.11.2023.
//

import Foundation

protocol MainCellModelProtocol {
    var id : String { get set }
    var avatarUrl : String { get set }
    var firstName : String { get set }
    var lastName : String { get set }
    var department : String { get set }
    var position : String { get set }
    var birthday : String { get set }
    var phone : String { get set }
    
}

struct MainCellModel : MainCellModelProtocol {
    
    var id: String
    var avatarUrl: String
    var firstName: String
    var lastName: String
    var department: String
    var position: String
    var birthday: String
    var phone: String
    
    
    
}
