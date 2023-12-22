//
//  UserModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 21.11.2023.
//

import Foundation

struct Employee : Decodable {
    let items : [EmployeeInfo]
}

struct EmployeeInfo : Decodable {
    let id : String
    let avatarUrl : String
    let firstName : String
    let lastName : String
    let userTag : String
    let department : String
    let position : String
    let birthday : String
    let phone : String
}

